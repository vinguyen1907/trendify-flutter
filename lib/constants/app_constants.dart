class AppConstants {
  static const double usdToVndExchangeRate = 24005;

  static const DataSource databaseSource = DataSource.firebase;
}

enum DataSource {
  firebase,
  api,
}
