part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadChatRoom extends ChatEvent {
  const LoadChatRoom({
    required this.imgUrl,
    required this.name,
  });
  final String imgUrl;
  final String name;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
