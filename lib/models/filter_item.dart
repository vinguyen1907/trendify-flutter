import 'package:ecommerce_app/constants/enums/sort_type.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterItem extends Equatable {
  final List<SortType>? sortTypes;
  final List<Category>? categories;
  final SfRangeValues? priceValues;
  final SortType? sortTypeSelected;
  final SfRangeValues? priceValuesSelected;
  final Category? categorySelected;
  final int? ratingSelected;
  const FilterItem(
      {required this.sortTypes,
      required this.categories,
      required this.priceValues,
      required this.priceValuesSelected,
      required this.categorySelected,
      required this.ratingSelected,
      required this.sortTypeSelected});

  FilterItem copyWith({
    List<SortType>? sortTypes,
    List<Category>? categories,
    SfRangeValues? priceValues,
    SortType? sortTypeSelected,
    SfRangeValues? priceValuesSelected,
    Category? categorySelected,
    int? ratingSelected,
  }) {
    return FilterItem(
      sortTypes: sortTypes ?? this.sortTypes,
      categories: categories ?? this.categories,
      priceValues: priceValues ?? this.priceValues,
      priceValuesSelected: priceValuesSelected ?? this.priceValuesSelected,
      categorySelected: categorySelected ?? this.categorySelected,
      ratingSelected: ratingSelected ?? this.ratingSelected,
      sortTypeSelected: sortTypeSelected ?? this.sortTypeSelected,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [categorySelected, priceValuesSelected, sortTypeSelected, ratingSelected];
}
