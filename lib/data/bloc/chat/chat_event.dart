part of 'chat_bloc.dart';

abstract class ChatEvent {}

class InitChatEvent extends ChatEvent {
  final int userId;
  InitChatEvent(this.userId);
}

class ReceiveMessagesEvent extends ChatEvent {
  final List<MessageData> messages;
  ReceiveMessagesEvent(this.messages);
}

class SendMessageEvent extends ChatEvent {
  final WebSocketMessage message;
  SendMessageEvent(this.message);
}

class AddTempMessageEvent extends ChatEvent {
  final MessageData message;
  AddTempMessageEvent(this.message);
}

class RemovePendingMessageEvent extends ChatEvent {
  final String messageId;
  RemovePendingMessageEvent(this.messageId);
}

class SetUploadingEvent extends ChatEvent {
  final bool isUploading;
  final String? messageId;
  SetUploadingEvent(this.isUploading, {this.messageId});
}

class DisposeChatEvent extends ChatEvent {}
