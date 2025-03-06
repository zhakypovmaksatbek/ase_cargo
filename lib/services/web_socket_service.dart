import 'dart:async';
import 'dart:convert';

import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart' as io;

class WebSocketService {
  late io.IOWebSocketChannel _channel;
  bool _isConnected = false;
  final StreamController<ChatMessage> _messageController =
      StreamController<ChatMessage>.broadcast();

  Stream<ChatMessage> get messages => _messageController.stream;

  Future<void> initWebSocket(BuildContext context) async {
    final String? token = await AppManager.instance.getToken();
    if (token == null) {
      print("Hata: Token bulunamadı!");
      return;
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
      print("✅ WebSocket Bağlantısı Kuruldu.");

      _channel.stream.listen(
        (message) {
          try {
            final decodedMessage = jsonDecode(message);
            final chatMessage = ChatMessage.fromJson(decodedMessage);

            _messageController.add(chatMessage);
            print(chatMessage.toString());
            print("📩 Yeni Mesaj: ${chatMessage.data?.text}");
          } catch (e) {
            print("❌ JSON Parse Hatası: $e");
          }
        },
        onDone: () {
          print("❌ WebSocket Bağlantısı Kapandı.");
          _isConnected = false;
          if (context.mounted) {
            _reconnect(context);
          }
        },
        onError: (error, stackTrace) {
          print("⚠️ WebSocket Hatası: $error");
          _isConnected = false;
          if (context.mounted) {
            _reconnect(context);
          }
        },
      );
    } catch (e) {
      print("🚨 WebSocket Bağlantı Hatası: $e");
      _isConnected = false;
      if (context.mounted) {
        _reconnect(context);
      }
    }
  }

  void _reconnect(BuildContext context) async {
    if (!_isConnected) {
      print("🔄 WebSocket Bağlantısı Yeniden Başlatılıyor...");

      // Yeniden bağlanmadan önce 5 saniye bekle
      await Future.delayed(Duration(seconds: 5));
      if (context.mounted) {
        initWebSocket(context);
      }
    }
  }

  void sendMessage(String message) {
    if (_isConnected) {
      final messageData = {
        'command': 'send_message',
        'data': {'text': message},
      };

      _channel.sink.add(jsonEncode(messageData)); // JSON'u String olarak gönder
      print("📤 Mesaj Gönderildi: $message");
    } else {
      print("⚠️ WebSocket Bağlantısı Yok, Mesaj Gönderilemedi.");
    }
  }

  void closeConnection() {
    _channel.sink.close();
    _messageController.close();
    _isConnected = false;
    print("🛑 WebSocket Bağlantısı Kapatıldı.");
  }

  bool get isConnected => _isConnected;
}
