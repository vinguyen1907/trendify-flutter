part of 'search_filter_bloc.dart';

abstract class SearchFilterEvent extends Equatable {
  const SearchFilterEvent();
}

class LoadResultProducts extends SearchFilterEvent {
  final String query;
  const LoadResultProducts({required this.query});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChooseCategory extends SearchFilterEvent {
  final Category category;
  const ChooseCategory({required this.category});

  @override
  // TODO: implement props
  List<Object?> get props => [category];
}

class ChoosePriceValues extends SearchFilterEvent {
  final SfRangeValues priceValues;
  const ChoosePriceValues({required this.priceValues});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChooseSortType extends SearchFilterEvent {
  final SortType sortType;
  const ChooseSortType({required this.sortType});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChooseRatting extends SearchFilterEvent {
  final int ratting;
  const ChooseRatting({required this.ratting});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApplyFilter extends SearchFilterEvent {
  const ApplyFilter();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
