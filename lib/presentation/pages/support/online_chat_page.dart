import 'package:ase/presentation/pages/support/widgets/chat_bubble.dart';
import 'package:ase/presentation/pages/support/widgets/message_input.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'OnlineChatRoute')
class OnlineChatPage extends StatefulWidget {
  const OnlineChatPage({super.key});

  @override
  State<OnlineChatPage> createState() => _OnlineChatPageState();
}

class _OnlineChatPageState extends State<OnlineChatPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Message> messages = [
    Message(
        senderId: 'user1',
        text:
            'Hello! Easy Localization] [DEBUG] Build Easy Localization] [DEBUG] Build Easy Localization] [DEBUG] Build',
        timestamp: DateTime.now()),
    Message(
        senderId: 'user2',
        text: 'Hi there!',
        timestamp: DateTime.now(),
        imageUrl: "https://picsum.photos/200"),
  ];
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
                return ChatBubble(message: message);
              },
            ),
          ),
          MessageInput(
              chatRoomId: '',
              onSendMessage: (message) {
                setState(() {
                  messages.add(Message(
                      senderId: "me",
                      text: message,
                      timestamp: DateTime.now()));
                });
              }),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class Message {
  final String senderId;
  final String? text;
  final String? imageUrl;
  final DateTime timestamp;

  Message({
    required this.senderId,
    this.text,
    required this.timestamp,
    this.imageUrl,
  });
}
