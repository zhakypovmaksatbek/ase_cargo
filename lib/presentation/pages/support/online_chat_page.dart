// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/presentation/pages/support/widgets/chat_bubble.dart';
import 'package:ase/presentation/pages/support/widgets/message_input.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:ase/services/web_socket_service.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'OnlineChatRoute')
class OnlineChatPage extends StatefulWidget {
  const OnlineChatPage({
    super.key,
    required this.userId,
  });
  final int userId;
  @override
  State<OnlineChatPage> createState() => _OnlineChatPageState();
}

class _OnlineChatPageState extends State<OnlineChatPage> {
  final WebSocketService _webSocketService = WebSocketService();

  @override
  void initState() {
    super.initState();
    _initWebSocket();
  }

  Future<void> _initWebSocket() async {
    await _webSocketService.initWebSocket(context);

    _webSocketService.messages.listen((messageJson) {
      try {
        final chatMessage = messageJson;

        setState(() {
          messages.add(chatMessage); // Yeni mesajı başa ekleyelim
        });
      } catch (e) {
        print("❌ JSON Parse Hatası: $e");
      }
    });
  }

  @override
  void dispose() {
    _webSocketService.closeConnection();
    super.dispose();
  }

  void _sendMessage(String message) {
    _webSocketService.sendMessage(message);
  }

  List<ChatMessage> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          style: CustomBoxDecoration.backButtonStyle(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages.reversed.toList()[index];
                return ChatBubble(message: message, userId: widget.userId);
              },
            ),
          ),
          MessageInput(
              chatRoomId: '',
              onSendMessage: (message) {
                _sendMessage(message);
                // setState(() {
                //   messages.add(ChatMessage(
                //       status: "sent",
                //       type: "text",
                //       data: MessageData(
                //           id: 1,
                //           chat: 1,
                //           text: message,
                //           sender: Sender(
                //               id: 1,
                //               firstName: "John",
                //               lastName: "Doe",
                //               avatar: "https://i.pravatar.cc/300"),
                //           createdAt: DateTime.now().toString(),
                //           attachments: ["https://i.pravatar.cc/300"])));
                // });
              }),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
