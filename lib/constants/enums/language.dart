import 'package:ecommerce_app/constants/app_assets.dart';

enum Language {
  vietnamese,
  english,
  bengali,
  german,
  portuguese,
}

Map<Language, String> languageToLanguageCode = {
  Language.vietnamese: 'vi',
  Language.english: 'en',
  Language.bengali: 'bn',
  Language.german: 'de',
  Language.portuguese: 'pt',
};

Map<String, Language> languageCodeToLanguage = {
  'vi': Language.vietnamese,
  'en': Language.english,
  'bn': Language.bengali,
  'de': Language.german,
  'pt': Language.portuguese,
};

Map<Language, String> languageToLanguageName = {
  Language.vietnamese: 'Vietnamese',
  Language.english: 'English',
  Language.bengali: 'Bengali',
  Language.german: 'German',
  Language.portuguese: 'Portuguese',
};

Map<Language, String> languageToFlag = {
  Language.vietnamese: AppAssets.imgVietnamFlag,
  Language.english: AppAssets.imgUKFlag,
  Language.bengali: AppAssets.imgBangladeshFlag,
  Language.german: AppAssets.imgGermanFlag,
  Language.portuguese: AppAssets.imgPortugalFlag,
};
