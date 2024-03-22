import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/image_message_item.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/text_message_item.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/voice_message_item.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return TextMessageItem(message: message);
      case MessageType.image:
        return ImageMessageItem(message: message);
      case MessageType.voice:
        return VoiceMessageItem(message: message);
      default:
        return Container();
    }
  }
}
