// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/widgets/user_profile_image.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final int userId;
  const ChatBubble({
    super.key,
    required this.message,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isMe = message.data?.isUserMessage ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            UserProfileImage(
              avatar: message.data?.sender?.avatar ?? "",
              size: 35,
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
                    // if (message.data.attachments != null)
                    //   Padding(
                    //     padding: const EdgeInsets.only(bottom: 8.0),
                    //     child: CashedImages(imageUrl: message.imageUrl!),
                    //   ),
                    if (!isMe)
                      AppText(
                        title: "Admin",
                        textType: TextType.body,
                        color: ColorConstants.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    if (message.data?.text?.isNotEmpty ?? false)
                      AppText(
                        title: message.data?.text ?? "",
                        textType: TextType.body,
                      ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        title: _formatTime(
                            DateTime.parse(message.data?.createdAt ?? "")),
                        textType: TextType.description,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(message.data?.sender?.avatar ?? ""),
              radius: 18,
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final localTime = time.toLocal();
    return '${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';
  }
}
