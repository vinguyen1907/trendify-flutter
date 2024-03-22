// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final Gender? gender;
  final int? age;
  final ShippingAddress? defaultShippingAddress;
  final double eWalletBalance;
  final String? fcmToken;

  UserProfile(
      {required this.id,
      required this.name,
      this.imageUrl = "",
      required this.gender,
      required this.age,
      required this.email,
      this.defaultShippingAddress,
      required this.eWalletBalance,
      this.fcmToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'gender': gender?.name,
      'age': age,
      'defaultShippingAddress': defaultShippingAddress,
      'eWalletBalance': eWalletBalance,
      'fcmToken': fcmToken
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        imageUrl: map['imageUrl'] as String,
        gender: map['gender'] == null
            ? Gender.notHave
            : (map['gender'] as String).toGender(),
        age: map['age'] != null ? map['age'] as int : null,
        defaultShippingAddress: map['defaultShippingAddress'] != null
            ? ShippingAddress.fromMap(
                map['defaultShippingAddress'] as Map<String, dynamic>)
            : null,
        eWalletBalance: map['eWalletBalance'] == null
            ? 0
            : map['eWalletBalance'].toDouble(),
        fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null);
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
