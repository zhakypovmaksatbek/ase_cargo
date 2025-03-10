part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState {
  final List<MessageData> messages;
  final bool isUploading;
  final String? pendingMessageId;
  final ChatStatus status;
  final String? errorMessage;

  ChatState({
    this.messages = const [],
    this.isUploading = false,
    this.pendingMessageId,
    this.status = ChatStatus.initial,
    this.errorMessage,
  });

  ChatState copyWith({
    List<MessageData>? messages,
    bool? isUploading,
    String? pendingMessageId,
    ChatStatus? status,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isUploading: isUploading ?? this.isUploading,
      pendingMessageId: pendingMessageId ?? this.pendingMessageId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
