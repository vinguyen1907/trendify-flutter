part of 'search_filter_bloc.dart';

abstract class SearchFilterState extends Equatable {
  const SearchFilterState();
}

class SearchFilterInitial extends SearchFilterState {
  @override
  List<Object> get props => [];
}

class SearchFilterLoading extends SearchFilterState {
  @override
  List<Object> get props => [];
}

class SearchFilterError extends SearchFilterState {
  final String message;

  const SearchFilterError({required this.message});
  @override
  List<Object> get props => [];
}

class SearchFilterLoaded extends SearchFilterState {
  final List<Product> resultProducts;
  final FilterItem filterItem;
  const SearchFilterLoaded({
    required this.resultProducts,
    required this.filterItem,
  });
  @override
  List<Object> get props => [resultProducts, filterItem];
}
