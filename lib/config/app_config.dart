import 'package:flutter/services.dart';

class AppConfig {
  static const int appIDCallService = 873318300;
  static const String appSignCallService =
      '5cdfa7af1e9db08e0a2b4e581c5bb600983aa40f2b9fd87b0193dde445721ed8';
  static const String mapUrlTemplate =
      "https://api.mapbox.com/styles/v1/vinguyen1907/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}";
  static const String mapBoxAccessToken =
      "pk.eyJ1IjoidmluZ3V5ZW4xOTA3IiwiYSI6ImNsbHRubXN3bDB0a3MzbHBobGt2OGNuNm8ifQ.6oNaNr-WUHZSqDfsefLG3Q";
  static const String mapBoxStyleId = "clltnt5bi00bc01pf7ede43ab";
  static const MethodChannel platform =
      MethodChannel('flutter.native/channelPayOrder');
}
