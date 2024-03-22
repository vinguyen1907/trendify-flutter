import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/chat_room.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/utils/chat_util.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ChatService {
  final String chatRoomId = FirebaseAuth.instance.currentUser!.uid;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> sendTextMessage(String content) async {
    final String messageId =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    final timestamp = DateTime.now();
    Message message = Message(
        id: messageId,
        senderId: userId,
        content: content.trim(),
        imageUrl: '',
        audioUrl: '',
        isRead: false,
        type: MessageType.text,
        timestamp: timestamp);
    await chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
    await chatRoomsRef.doc(chatRoomId).update({'lastMessageTime': timestamp});
  }

  Future<void> sendImageMessage(List<XFile> images) async {
    final String info =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    final timestamp = DateTime.now();
    for (int i = 0; i < images.length; i++) {
      final messageId = info + i.toString();
      final imageFile = File(images[i].path);
      final compressImageFile = await ChatUtil().compressImage(imageFile);
      try {
        final storageRef =
            FirebaseStorage.instance.ref().child('chat/chat_img');
        final task = await storageRef
            .child(
                '${userId + DateTime.now().millisecondsSinceEpoch.toString()}.jpg')
            .putFile(compressImageFile);
        final linkImage = await task.ref.getDownloadURL();
        Message message = Message(
            id: messageId,
            senderId: userId,
            content: '',
            imageUrl: linkImage,
            audioUrl: '',
            isRead: false,
            type: MessageType.image,
            timestamp: timestamp);
        await chatRoomsRef
            .doc(chatRoomId)
            .collection('messages')
            .doc(messageId)
            .set(message.toMap());
        await chatRoomsRef
            .doc(chatRoomId)
            .update({'lastMessageTime': timestamp});
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> sendVoiceMessage(String filePath) async {
    final String messageId =
        userId + DateTime.now().millisecondsSinceEpoch.toString();
    final timestamp = DateTime.now();
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('chat/chat_voice');
      final task = await storageRef
          .child(
              '$userId${DateTime.now().millisecondsSinceEpoch.toString()}.m4a')
          .putFile(
            File(filePath),
            SettableMetadata(contentType: 'audio/mpeg'),
          );
      final linkAudio = await task.ref.getDownloadURL();
      Message message = Message(
          id: messageId,
          senderId: userId,
          content: '',
          imageUrl: '',
          audioUrl: linkAudio,
          isRead: false,
          type: MessageType.voice,
          timestamp: timestamp);
      await chatRoomsRef
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
      await chatRoomsRef.doc(chatRoomId).update({'lastMessageTime': timestamp});
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot> getMessages() {
    return chatRoomsRef
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> checkAndCreateChatRoom(String name, String imgUrl) async {
    final QuerySnapshot existingRooms =
        await chatRoomsRef.where('id', isEqualTo: chatRoomId).get();

    if (existingRooms.docs.isEmpty) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      final ChatRoom roomData = ChatRoom(
          id: chatRoomId,
          name: name,
          imgUrl: imgUrl,
          userId: userId,
          userToken: token,
          adminToken: null,
          lastMessageTime: null,
          createdAt: DateTime.now());

      await chatRoomsRef.doc(chatRoomId).set(roomData.toMap());
    } else {}
  }

  void markMessageAsRead(String messageId) {
    final messageRef =
        chatRoomsRef.doc(chatRoomId).collection('messages').doc(messageId);
    messageRef.update({
      'isRead': true,
    });
  }
}
