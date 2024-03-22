part of 'category_product_bloc.dart';

abstract class CategoryProductEvent extends Equatable {
  const CategoryProductEvent();
}

class LoadProductsInCategory extends CategoryProductEvent {
  const LoadProductsInCategory({required this.category});
  final Category category;
  @override
  // TODO: implement props
  List<Object?> get props => [category];
}

class SearchProducts extends CategoryProductEvent {
  const SearchProducts({required this.query});
  final String query;
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}
