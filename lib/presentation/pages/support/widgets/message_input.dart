import 'dart:convert';
import 'dart:io';

import 'package:ase/data/models/web_socket_message.dart';
import 'package:ase/data/provider/message_provider.dart';
import 'package:ase/presentation/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MessageInput extends StatefulWidget {
  final ValueChanged<WebSocketMessage> onSendMessage;
  const MessageInput({super.key, required this.onSendMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    Provider.of<MessageProvider>(context, listen: false)
        .updateMessage(_controller.text);
  }

  Future<String?> _convertImageToBase64(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);
      return base64Image;
    } catch (e) {
      debugPrint('Resim base64 dönüştürme hatası: $e');
      return null;
    }
  }

  Future<void> _sendMessage() async {
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    final message = _controller.text.trim();

    if (messageProvider.canSendMessage()) {
      final String messageId = Uuid().v4();
      messageProvider.setUploading(true, messageId: messageId);
      List<String>? base64Files;

      // Eğer resim seçilmişse, base64'e dönüştür
      if (messageProvider.selectedImage != null) {
        final base64Image =
            await _convertImageToBase64(messageProvider.selectedImage!.path);
        if (base64Image != null) {
          base64Files = [base64Image];
        }
      }

      // WebSocketMessage oluştur
      final webSocketMessage = WebSocketMessage.sendMessage(
          text: message,
          files: base64Files,
          withData: base64Files?.isNotEmpty ?? false);

      // Mesajı gönder
      widget.onSendMessage(webSocketMessage);

      // Alanları temizle
      _controller.clear();
      messageProvider.clearMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Seçilen resim gösterimi
              if (messageProvider.selectedImage != null)
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: FileImage(
                              File(messageProvider.selectedImage!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          messageProvider.removeSelectedImage();
                        },
                      ),
                    ),
                  ],
                ),
              Row(
                children: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.attach_file),
                    onSelected: (value) {
                      if (value == 'gallery') {
                        messageProvider.pickImageFromGallery(context);
                      } else if (value == 'camera') {
                        messageProvider.pickImageFromCamera(context);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'gallery',
                        child: Row(
                          children: [
                            Icon(Icons.photo_library),
                            SizedBox(width: 8),
                            Text('Galeri'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'camera',
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(width: 8),
                            Text('Kamera'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      onEditingComplete: _sendMessage,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: messageProvider.canSendMessage()
                              ? IconButton.filled(
                                  icon: const Icon(
                                    Icons.arrow_upward_sharp,
                                    color: ColorConstants.white,
                                  ),
                                  onPressed: _sendMessage,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
