import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:ecommerce_app/constants/firebase_constants.dart';

class UserRepository implements IUserRepository {
  @override
  Future<UserProfile> fetchUser() async {
    try {
      final DocumentSnapshot doc =
          await usersRef.doc(firebaseAuth.currentUser!.uid).get();
      return UserProfile.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser({
    String? name,
    String? gender,
    int? age,
    String? email,
    XFile? image,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (name != null) {
        data["name"] = name;
      }
      if (gender != null) {
        data["gender"] = gender;
      }
      if (age != null) {
        data["age"] = age;
      }
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("avatar_img/${firebaseAuth.currentUser!.uid}");
        await ref.putFile(File(image.path));
        final url = await ref.getDownloadURL();
        data["imageUrl"] = url;
      }
      if (data.isNotEmpty) {
        await usersRef.doc(firebaseAuth.currentUser!.uid).update(data);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> createNewUser({
    required String id,
    required String email,
    required String name,
  }) async {
    final UserProfile userProfile = UserProfile(
      id: firebaseAuth.currentUser!.uid,
      name: name,
      gender: null,
      age: null,
      email: email,
      eWalletBalance: 0,
    );
    try {
      await usersRef.doc(id).set(userProfile.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateDefaultShippingAddress(
      {required ShippingAddress newDefaultAddress}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .update({"defaultShippingAddress": newDefaultAddress.toMap()});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateFcmToken(String userId) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .update({"fcmToken": fcmToken});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> recordUserClick(Product product) {
    // TODO: implement recordUserClick
    throw UnimplementedError();
  }
}
