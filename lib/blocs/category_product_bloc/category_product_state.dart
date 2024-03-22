part of 'category_product_bloc.dart';

abstract class CategoryProductState extends Equatable {
  const CategoryProductState();
}

class CategoryProductInitial extends CategoryProductState {
  @override
  List<Object> get props => [];
}

class CategoryProductLoading extends CategoryProductState {
  @override
  List<Object> get props => [];
}

class CategoryProductLoaded extends CategoryProductState {
  final List<Product> products;

  const CategoryProductLoaded({required this.products});
  @override
  List<Object> get props => [products];
}

class CategoryProductError extends CategoryProductState {
  final String message;

  const CategoryProductError({required this.message});
  @override
  List<Object> get props => [];
}
