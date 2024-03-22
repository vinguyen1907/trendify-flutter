part of 'product_screen_bloc.dart';

abstract class ProductScreenEvent extends Equatable {
  const ProductScreenEvent();
}

class LoadProducts extends ProductScreenEvent {
  const LoadProducts({required this.sectionName, required this.products});
  final String sectionName;
  final List<Product> products;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchProduct extends ProductScreenEvent {
  const SearchProduct({required this.query});
  final String query;
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}
