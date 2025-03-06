// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessage {
  String? status;
  String? type;
  MessageData? data;

  ChatMessage({
    this.status,
    this.type,
    this.data,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      status: json["status"],
      type: json["type"],
      data: MessageData.fromJson(json["data"]),
    );
  }

  @override
  String toString() => 'ChatMessage(status: $status, type: $type, data: $data)';
}

class MessageData {
  int? id;
  int? chat;
  String? text;
  Sender? sender;
  String? createdAt;
  bool? isUserMessage;
  List<String>? attachments;

  MessageData({
    required this.id,
    required this.chat,
    required this.text,
    required this.sender,
    required this.createdAt,
    required this.attachments,
    this.isUserMessage,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json["id"],
      chat: json["chat"],
      text: json["text"],
      sender: Sender.fromJson(json["sender"]),
      createdAt: json["created_at"],
      isUserMessage: json["is_user_message"],
      attachments: List<String>.from(json["attachments"] ?? []),
    );
  }

  @override
  String toString() {
    return 'MessageData(id: $id, chat: $chat, text: $text, sender: $sender, createdAt: $createdAt, attachments: $attachments, isUserMessage: $isUserMessage)';
  }
}

class Sender {
  int? id;
  String? firstName;
  String? lastName;
  String? avatar;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      avatar: json["avatar"],
    );
  }

  @override
  String toString() {
    return 'Sender(id: $id, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
  }
}
