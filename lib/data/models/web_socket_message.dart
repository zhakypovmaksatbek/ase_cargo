import 'package:ase/data/models/chat_message_model.dart';

class WebSocketMessage {
  final MessageType command;
  final WebSocketMessageData data;
  final bool withData;

  WebSocketMessage({
    required this.command,
    required this.data,
    this.withData = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'command': command.toJson(),
      'data': data.toJson(),
    };
  }

  factory WebSocketMessage.sendMessage({
    required String text,
    List<String>? files,
    bool withData = false,
  }) {
    return WebSocketMessage(
      command: MessageType.sendMessage,
      data: WebSocketMessageData(
        text: text,
        files: files ?? [],
      ),
      withData: withData,
    );
  }

  factory WebSocketMessage.readChatMessages() {
    return WebSocketMessage(
      command: MessageType.chatMessages,
      data: WebSocketMessageData(),
    );
  }

  factory WebSocketMessage.unreadMessages() {
    return WebSocketMessage(
      command: MessageType.unreadMessages,
      data: WebSocketMessageData(),
    );
  }
}

class WebSocketMessageData {
  final String? text;
  final List<String>? files;

  WebSocketMessageData({
    this.text,
    this.files,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (text != null) data['text'] = text;
    if (files != null) data['files'] = files;

    return data;
  }
}
