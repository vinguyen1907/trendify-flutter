import 'package:ecommerce_app/constants/enums/sort_type.dart';

extension StringExtensions on String {}

extension DoubleExtensions on double {
  String toPriceString() {
    return "\$${toStringAsFixed(2)}";
  }

  double countDigits() {
    if (this == 0) {
      return 1;
    }

    int count = 0;
    int intValue = toInt();

    while (intValue != 0) {
      count++;
      intValue ~/= 10;
    }

    return count.toDouble();
  }
}

extension SortTypeExtension on SortType {
  String getName() {
    switch (this) {
      case SortType.newToday:
        return "New Today";
      case SortType.newThisWeek:
        return "New This Week";
      case SortType.topSellers:
        return "Top Sellers";
      default:
        return "Unknown";
    }
  }
}
