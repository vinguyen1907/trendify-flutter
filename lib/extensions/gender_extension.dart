import 'package:ecommerce_app/constants/enums/enums.dart';

extension GenderExtension on Gender {
  String toShortString() {
    return this == Gender.male ? "Male" : "Female";
  }
}
