import 'package:ecommerce_app/constants/enums/language.dart';

extension LanguageExt on Language {
  String get flag {
    return languageToFlag[this] ?? languageToFlag[Language.english]!;
  }

  String get code {
    return languageToLanguageCode[this] ??
        languageToLanguageCode[Language.english]!;
  }
}
