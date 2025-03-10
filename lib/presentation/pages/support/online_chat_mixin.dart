import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/data/models/web_socket_message.dart';
import 'package:ase/data/provider/message_provider.dart';
import 'package:ase/presentation/pages/support/online_chat_page.dart';
import 'package:ase/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin OnlineChatMixin on State<OnlineChatPage> {
  String userName = "";
  String avatar = "";
  final WebSocketService webSocketService = WebSocketService();

  Future<void> initWebSocket(BuildContext context) async {
    await webSocketService.initWebSocket(context);

    webSocketService.messages.listen((chatMessage) {
      try {
        if (context.mounted) {
          final messageProvider =
              Provider.of<MessageProvider>(context, listen: false);

          // Önce geçici mesajı kaldır
          if (messageProvider.isUploading) {
            setState(() {
              messages.removeWhere((element) =>
                  element.localeMessageId == messageProvider.pendingMessageId);
            });

            // Yükleme durumunu sonlandır
            messageProvider.setUploading(false);
          }

          // Sonra yeni mesajları ekle
          setState(() {
            if (chatMessage.data != null) {
              messages.addAll(chatMessage.data!);

              // Mesajları tarihlerine göre sırala
              messages.sort((a, b) {
                final DateTime dateTimeA = DateTime.parse(a.createdAt ?? "");
                final DateTime dateTimeB = DateTime.parse(b.createdAt ?? "");
                return dateTimeB.compareTo(dateTimeA);
              });
            }
          });
        }
      } catch (e) {
        print("❌ JSON Parse Hatası: $e");
      }
    });
  }

  // Geçici mesaj oluşturan yardımcı metot
  MessageData _createTempMessage(String text, String? tempMessageId) {
    // Kullanıcı bilgilerini bul
    Sender? userSender;
    try {
      final userMessage =
          messages.firstWhere((element) => element.isUserMessage ?? false);
      userSender = userMessage.sender;
    } catch (e) {
      // Kullanıcı mesajı bulunamazsa varsayılan değerler kullan
      userSender = Sender(
          id: widget.userId, firstName: "Kullanıcı", lastName: "", avatar: "");
    }

    return MessageData(
        localeMessageId: tempMessageId,
        text: text,
        isUserMessage: true,
        createdAt: DateTime.now().toIso8601String(),
        sender: Sender(
            id: widget.userId,
            firstName: userSender?.firstName ?? "",
            lastName: userSender?.lastName ?? "",
            avatar: userSender?.avatar ?? ""),
        attachments: [],
        id: 1,
        chat: 1);
  }

  void sendMessage(WebSocketMessage data) {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);

    // Önce yükleme durumunu başlat ve tempMessageId oluştur
    final tempMessageId = DateTime.now().millisecondsSinceEpoch.toString();
    messageProvider.setUploading(true, messageId: tempMessageId);

    if (data.withData) {
      // Geçici mesaj oluştur
      final tempMessage =
          _createTempMessage(data.data.text ?? "", tempMessageId);

      // Geçici mesajı ekle
      setState(() {
        messages.insert(0, tempMessage);
      });
    }

    // Mesajı gönder
    webSocketService.sendMessage(data);
  }

  List<MessageData> messages = [];
}
