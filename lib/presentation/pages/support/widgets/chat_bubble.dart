// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/data/provider/message_provider.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:ase/presentation/pages/profile/widgets/user_profile_image.dart';
import 'package:ase/presentation/widgets/image/cashed_images.dart';
import 'package:ase/presentation/widgets/text/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final MessageData message;
  final int userId;
  const ChatBubble({
    super.key,
    required this.message,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isMe = message.isUserMessage ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            UserProfileImage(
              avatar: message.sender?.avatar ?? "",
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
                    if (!isMe)
                      AppText(
                        title: message.sender?.firstName ?? "-",
                        textType: TextType.body,
                        color: ColorConstants.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    if (message.attachments != null &&
                        message.attachments!.isNotEmpty)
                      _imageWidget(message.attachments![0].file ?? ""),
                    if (message.text?.isNotEmpty ?? false)
                      AppText(
                        title: message.text ?? "",
                        textType: TextType.body,
                      ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppText(
                        title: _formatTime(
                            DateTime.parse(message.createdAt ?? "")),
                        textType: TextType.description,
                      ),
                    ),
                    Consumer<MessageProvider>(
                      builder: (context, messageProvider, child) {
                        final bool isUploading = messageProvider.isUploading &&
                            (message.isUserMessage ?? false) &&
                            message.localeMessageId != null;
                        if (isUploading) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorConstants.primary,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  LocaleKeys.general_sending_message.tr(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black54),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isMe)
            UserProfileImage(
              avatar: message.sender?.avatar ?? "",
              size: 35,
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final localTime = time.toLocal();
    return '${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _imageWidget(String imageUrl) {
    if (kDebugMode) {
      print(message.attachments.toString());
    }
    if (message.attachments != null && message.attachments!.isNotEmpty) {
      final fileExtension =
          message.attachments![0].file?.split('.').last.toLowerCase();
      if (fileExtension == 'png' ||
          fileExtension == 'jpg' ||
          fileExtension == 'jpeg') {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CashedImages(
            imageUrl: message.attachments![0].file ?? "",
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }
}
