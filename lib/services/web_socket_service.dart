import 'dart:async';
import 'dart:convert';

import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/data/models/web_socket_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart' as io;

class WebSocketService {
  late io.IOWebSocketChannel _channel;
  bool _isConnected = false;
  final StreamController<ChatMessagesResponse> _messageController =
      StreamController<ChatMessagesResponse>.broadcast();

  Stream<ChatMessagesResponse> get messages => _messageController.stream;

  Future<void> initWebSocket(BuildContext context) async {
    final String? token = await AppManager.instance.getToken();
    if (token == null) {
      if (kDebugMode) {
        print("Hata: Token bulunamadı!");
      }
      throw Exception("Token bulunamadı!");
    }

    final uri = Uri.parse('wss://asecourier.kg/ws/chat/user/');

    try {
      _channel = io.IOWebSocketChannel.connect(
        uri,
        headers: {
          "origin": "https://asecourier.kg",
          "Authorization": "Bearer $token",
        },
      );

      _isConnected = true;
      if (kDebugMode) {
        print("✅ WebSocket Bağlantısı Kuruldu.");
      }
      final initialMessage = {'command': 'chat_messages'};
      _channel.sink.add(jsonEncode(initialMessage));
      _channel.stream.listen(
        (message) {
          try {
            final decodedMessage = jsonDecode(message);
            final chatMessagesResponse =
                ChatMessagesResponse.fromJson(decodedMessage);

            // Gelen mesajları işleme
            _messageController.add(chatMessagesResponse);
          } catch (e) {
            if (kDebugMode) {
              print(message);
              print("❌ JSON Parse Hatası: $e");
            }
          }
        },
        onDone: () {
          if (kDebugMode) {
            print("❌ WebSocket Bağlantısı Kapandı.");
          }
          _isConnected = false;
          if (context.mounted) {
            _reconnect(context);
          }
        },
        onError: (error, stackTrace) {
          if (kDebugMode) {
            print("⚠️ WebSocket Hatası: $error");
          }
          _isConnected = false;
          if (context.mounted) {
            _reconnect(context);
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("🚨 WebSocket Bağlantı Hatası: $e");
      }
      _isConnected = false;
      if (context.mounted) {
        _reconnect(context);
      }
      throw Exception("WebSocket Bağlantı Hatası: $e");
    }
  }

  void _reconnect(BuildContext context) async {
    if (!_isConnected) {
      if (kDebugMode) {
        print("🔄 WebSocket Bağlantısı Yeniden Başlatılıyor...");
      }

      // Yeniden bağlanmadan önce 5 saniye bekle
      await Future.delayed(Duration(seconds: 5));
      if (context.mounted) {
        initWebSocket(context);
      }
    }
  }

  void sendMessage(WebSocketMessage data) {
    if (_isConnected) {
      final messageData = data.toJson();
      final jsonString = jsonEncode(messageData);

      _channel.sink.add(jsonString);
      if (kDebugMode) {
        print("📤 Mesaj Gönderildi: $messageData");
      }
    } else {
      if (kDebugMode) {
        print("⚠️ WebSocket Bağlantısı Yok, Mesaj Gönderilemedi.");
      }
    }
  }

  void closeConnection() {
    if (_isConnected) {
      _channel.sink.close();
      _messageController.close();
      _isConnected = false;
      if (kDebugMode) {
        print("🛑 WebSocket Bağlantısı Kapatıldı.");
      }
    }
  }

  bool get isConnected => _isConnected;
}
