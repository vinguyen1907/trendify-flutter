part of 'product_screen_bloc.dart';

abstract class ProductScreenState extends Equatable {
  const ProductScreenState();
}

class ProductScreenInitial extends ProductScreenState {
  @override
  List<Object> get props => [];
}

class ProductScreenLoading extends ProductScreenState {
  @override
  List<Object> get props => [];
}

class ProductScreenLoaded extends ProductScreenState {
  final String sectionName;
  final List<Product> products;

  const ProductScreenLoaded(
      {required this.sectionName, required this.products});
  @override
  List<Object> get props => [products, sectionName];
}

class ProductScreenError extends ProductScreenState {
  final String message;

  const ProductScreenError({required this.message});
  @override
  List<Object> get props => [];
}
