class AppConstants {
  static const double usdToVndExchangeRate = 24005;

  static const DataSource databaseSource = DataSource.firebase;
}

enum DataSource {
  firebase,
  api,
}

final List<int> defaultTopUpAmounts = [10, 20, 50, 100, 200, 250, 500, 750, 1000];
