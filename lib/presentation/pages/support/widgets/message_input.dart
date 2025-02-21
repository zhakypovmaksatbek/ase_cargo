import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final String chatRoomId;
  final ValueChanged<String> onSendMessage;
  const MessageInput(
      {super.key, required this.chatRoomId, required this.onSendMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _showSendButton = ValueNotifier<bool>(false);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.addListener(messageListener);
    super.initState();
  }

  void messageListener() {
    _controller.text.isNotEmpty
        ? _showSendButton.value = true
        : _showSendButton.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.folder_open_outlined)),
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              // onChanged: (value) => setState(() {}),
              onEditingComplete: () async {
                final message = _controller.text.trim();
                if (message.isNotEmpty) {
                  // Mesajı Firestore'a kaydet
                  // await sendMessage(chatRoomId, message);
                  _controller.clear();
                }
              },
              decoration: InputDecoration(
                hintText: 'Type a message...',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ValueListenableBuilder<bool>(
                      valueListenable: _showSendButton,
                      builder: (context, value, child) {
                        if (!value) {
                          return SizedBox();
                        }
                        return IconButton.filled(
                          icon: Icon(
                            Icons.arrow_upward_sharp,
                            color: ColorConstants.white,
                          ),
                          onPressed: () async {
                            final message = _controller.text.trim();
                            if (message.isNotEmpty) {
                              widget.onSendMessage(message);
                              // Mesajı Firestore'a kaydet
                              // await sendMessage(chatRoomId, message);
                              _controller.clear();
                            }
                          },
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
