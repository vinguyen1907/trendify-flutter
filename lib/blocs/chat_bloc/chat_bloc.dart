import 'dart:async';

import 'package:ecommerce_app/services/chat_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatRoom>(_onLoadChatRoom);
  }

  FutureOr<void> _onLoadChatRoom(
      LoadChatRoom event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    await ChatService().checkAndCreateChatRoom(event.name, event.imgUrl);
    emit(const ChatLoaded());
  }
}
