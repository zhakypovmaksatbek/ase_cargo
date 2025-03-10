import 'dart:async';

import 'package:ase/data/models/chat_message_model.dart';
import 'package:ase/data/models/web_socket_message.dart';
import 'package:ase/services/web_socket_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketService _webSocketService;
  StreamSubscription? _messagesSubscription;
  final BuildContext context;

  ChatBloc({required WebSocketService webSocketService, required this.context})
      : _webSocketService = webSocketService,
        super(ChatState()) {
    on<InitChatEvent>(_onInitChat);
    on<ReceiveMessagesEvent>(_onReceiveMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<AddTempMessageEvent>(_onAddTempMessage);
    on<RemovePendingMessageEvent>(_onRemovePendingMessage);
    on<SetUploadingEvent>(_onSetUploading);
    on<DisposeChatEvent>(_onDisposeChat);
  }

  Future<void> _onInitChat(InitChatEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));

    try {
      await _webSocketService.initWebSocket(context);

      // WebSocket mesajlarını dinle
      _messagesSubscription =
          _webSocketService.messages.listen((chatMessagesResponse) {
        try {
          if (chatMessagesResponse.data != null) {
            add(ReceiveMessagesEvent(chatMessagesResponse.data!));
          }
        } catch (e) {
          if (kDebugMode) {
            print("❌ JSON Parse Hatası: $e");
          }
        }
      });

      emit(state.copyWith(status: ChatStatus.loaded));
    } catch (e) {
      if (kDebugMode) {
        print("❌ WebSocket Bağlantı Hatası: $e");
      }
      emit(state.copyWith(
        status: ChatStatus.error,
        errorMessage: "Sohbet bağlantısı kurulamadı: $e",
      ));
    }
  }

  void _onReceiveMessages(ReceiveMessagesEvent event, Emitter<ChatState> emit) {
    // Önce geçici mesajı kaldır
    if (state.isUploading && state.pendingMessageId != null) {
      final filteredMessages = state.messages
          .where((element) => element.localeMessageId != state.pendingMessageId)
          .toList();

      // Yeni mesajları ekle
      final newMessages = [...filteredMessages, ...event.messages];

      // Mesajları tarihlerine göre sırala
      newMessages.sort((a, b) {
        final DateTime dateTimeA = DateTime.parse(a.createdAt ?? "");
        final DateTime dateTimeB = DateTime.parse(b.createdAt ?? "");
        return dateTimeB.compareTo(dateTimeA);
      });

      emit(state.copyWith(
        messages: newMessages,
        isUploading: false,
        pendingMessageId: null,
      ));
    } else {
      // Sadece yeni mesajları ekle
      final newMessages = [...state.messages, ...event.messages];

      // Mesajları tarihlerine göre sırala
      newMessages.sort((a, b) {
        final DateTime dateTimeA = DateTime.parse(a.createdAt ?? "");
        final DateTime dateTimeB = DateTime.parse(b.createdAt ?? "");
        return dateTimeB.compareTo(dateTimeA);
      });

      emit(state.copyWith(messages: newMessages));
    }
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) {
    if (event.message.withData) {
      // Geçici mesaj oluştur
      final tempMessageId = DateTime.now().millisecondsSinceEpoch.toString();

      // Yükleme durumunu başlat
      emit(state.copyWith(
        isUploading: true,
        pendingMessageId: tempMessageId,
      ));

      // Geçici mesaj oluştur
      final tempMessage = _createTempMessage(
        event.message.data.text ?? "",
        tempMessageId,
      );

      // Geçici mesajı ekle
      add(AddTempMessageEvent(tempMessage));
    }

    // Mesajı gönder
    _webSocketService.sendMessage(event.message);
  }

  void _onAddTempMessage(AddTempMessageEvent event, Emitter<ChatState> emit) {
    final newMessages = [event.message, ...state.messages];
    emit(state.copyWith(messages: newMessages));
  }

  void _onRemovePendingMessage(
      RemovePendingMessageEvent event, Emitter<ChatState> emit) {
    final newMessages = state.messages
        .where((element) => element.localeMessageId != event.messageId)
        .toList();
    emit(state.copyWith(
      messages: newMessages,
      isUploading: false,
      pendingMessageId: null,
    ));
  }

  void _onSetUploading(SetUploadingEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      isUploading: event.isUploading,
      pendingMessageId: event.messageId,
    ));
  }

  Future<void> _onDisposeChat(
      DisposeChatEvent event, Emitter<ChatState> emit) async {
    await _messagesSubscription?.cancel();
    _webSocketService.closeConnection();
    emit(ChatState());
  }

  // Geçici mesaj oluşturan yardımcı metot
  MessageData _createTempMessage(
    String text,
    String tempMessageId,
  ) {
    // Kullanıcı bilgilerini bul
    Sender? userSender;
    try {
      final userMessage = state.messages
          .firstWhere((element) => element.isUserMessage ?? false);
      userSender = userMessage.sender;
    } catch (e) {
      // Kullanıcı mesajı bulunamazsa varsayılan değerler kullan
      userSender =
          Sender(id: 0, firstName: "Kullanıcı", lastName: "", avatar: "");
    }

    return MessageData(
      localeMessageId: tempMessageId,
      text: text,
      isUserMessage: true,
      createdAt: DateTime.now().toIso8601String(),
      sender: Sender(
        id: userSender?.id,
        firstName: userSender?.firstName ?? "",
        lastName: userSender?.lastName ?? "",
        avatar: userSender?.avatar ?? "",
      ),
      attachments: [],
      id: 0,
      chat: 0,
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _webSocketService.closeConnection();
    return super.close();
  }
}
