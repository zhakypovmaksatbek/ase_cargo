// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessagesResponse {
  String? status;
  MessageType? type;
  List<MessageData>? data;

  ChatMessagesResponse({
    required this.status,
    required this.type,
    required this.data,
  });

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessagesResponse(
      status: json["status"],
      type: MessageType.fromString(json["type"]),
      data: _parseData(json["data"]),
    );
  }

  static List<MessageData>? _parseData(dynamic data) {
    if (data is List) {
      // Eğer data bir liste ise
      return data.map((item) => MessageData.fromJson(item)).toList();
    } else if (data is Map<String, dynamic>) {
      // Eğer data bir nesne ise
      return [MessageData.fromJson(data)];
    }
    return null; // data ne liste ne de nesne ise null döner
  }

  @override
  String toString() {
    return 'ChatMessagesResponse(status: $status, type: $type, data: $data)';
  }
}

class MessageData {
  int? id;
  int? chat;
  String? text;
  String? localeMessageId;
  Sender? sender;
  String? createdAt;
  bool? isUserMessage;
  List<AttachmentsModel>? attachments;

  MessageData({
    required this.id,
    required this.chat,
    required this.text,
    required this.sender,
    required this.createdAt,
    required this.attachments,
    this.isUserMessage,
    this.localeMessageId,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      id: json["id"],
      chat: json["chat"],
      text: json["text"],
      sender: Sender.fromJson(json["sender"]),
      createdAt: json["created_at"],
      isUserMessage: json["is_user_message"],
      attachments: json["attachments"] != null
          ? List<AttachmentsModel>.from(
              json["attachments"].map((x) => AttachmentsModel.fromJson(x)))
          : null,
    );
  }

  @override
  String toString() {
    return 'MessageData(id: $id, chat: $chat, text: $text, sender: $sender, createdAt: $createdAt, attachments: $attachments, isUserMessage: $isUserMessage)';
  }
}

class AttachmentsModel {
  int? id;
  String? file;
  String? createdAt;

  AttachmentsModel({this.id, this.file, this.createdAt});

  AttachmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file'] = file;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return 'AttachmentsModel(id: $id, file: $file, createdAt: $createdAt)';
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

enum MessageType {
  unreadMessages(key: 'unread_messages'),
  chatMessages(key: 'chat_messages'),
  sendMessage(key: 'send_message'),
  unknown(key: 'unknown');

  final String key;

  const MessageType({required this.key});

  static MessageType fromString(String value) {
    return MessageType.values
        .firstWhere((e) => e.name == value, orElse: () => MessageType.unknown);
  }
}

extension MessageTypeExtension on MessageType {
  String toJson() {
    switch (this) {
      case MessageType.unreadMessages:
        return 'unread_messages';
      case MessageType.chatMessages:
        return 'chat_messages';
      case MessageType.sendMessage:
        return 'send_message';
      case MessageType.unknown:
        return 'unknown';
    }
  }
}
