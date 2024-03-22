import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentInformation {
  final String id;
  final String? holderName;
  final String? cardNumber;
  final String? expiryDate;
  final String? cvvCode;
  final String type;

  PaymentInformation({
    required this.id,
    this.holderName,
    this.cardNumber,
    this.expiryDate,
    this.cvvCode,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'holderName': holderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvvCode': cvvCode,
      'cardType': type,
    };
  }

  factory PaymentInformation.fromMap(Map<String, dynamic> map) {
    return PaymentInformation(
      id: map['id'] as String,
      holderName: map['holderName'] as String?,
      cardNumber: map['cardNumber'] as String?,
      expiryDate: map['expiryDate'] as String?,
      cvvCode: map['cvvCode'] as String?,
      type: map['cardType'] ?? "cash_on_delivery",
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentInformation.fromJson(String source) =>
      PaymentInformation.fromMap(json.decode(source) as Map<String, dynamic>);
}
