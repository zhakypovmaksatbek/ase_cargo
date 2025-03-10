// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/provider/message_provider.dart';
import 'package:ase/presentation/pages/support/online_chat_mixin.dart';
import 'package:ase/presentation/pages/support/widgets/chat_bubble.dart';
import 'package:ase/presentation/pages/support/widgets/message_input.dart';
import 'package:ase/presentation/products/decoration/custom_decorations.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class _OnlineChatPageState extends State<OnlineChatPage> with OnlineChatMixin {
  @override
  void initState() {
    super.initState();
    initWebSocket(context);

    // Widget ağacı oluştuktan sonra Provider'a eriş
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);

      // Mesaj alındığında yükleme durumunu sonlandır
      if (messageProvider.isUploading) {
        messageProvider.setUploading(false);
        messages.removeWhere((element) =>
            element.localeMessageId == messageProvider.pendingMessageId);
      }
    });
  }

  @override
  void dispose() {
    webSocketService.closeConnection();
    super.dispose();
  }

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
                final message = messages[index];
                return ChatBubble(message: message, userId: widget.userId);
              },
            ),
          ),
          MessageInput(onSendMessage: (data) {
            sendMessage(data);
          }),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
