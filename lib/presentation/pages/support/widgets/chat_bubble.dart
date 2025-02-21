import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/support/online_chat_page.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMe = message.senderId == 'me';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            const CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
              radius: 18,
            ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.7,
            ),
            child: IntrinsicWidth(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: ColorConstants.dividerColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(14),
                    bottomRight: const Radius.circular(14),
                    topLeft: Radius.circular(isMe ? 14 : 0),
                    topRight: Radius.circular(isMe ? 0 : 14),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (message.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CashedImages(imageUrl: message.imageUrl!),
                      ),
                    if (message.text?.isNotEmpty ?? false)
                      AppText(
                        title: message.text ?? "",
                        textType: TextType.body,
                      ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        title: _formatTime(message.timestamp),
                        textType: TextType.description,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isMe)
            const CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
              radius: 18,
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
