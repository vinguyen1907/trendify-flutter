part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategory extends CategoryEvent {
  const LoadCategory();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchCategory extends CategoryEvent {
  const SearchCategory({required this.query});
  final String query;
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}
