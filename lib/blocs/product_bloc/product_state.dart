part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductDetail> productDetails;
  final Map<String, List<ProductDetail>> sizeGroups;
  final String productId;
  final String sizeSelected;
  final String colorSelected;
  final int quantity;
  const ProductLoaded({
    required this.productId,
    required this.productDetails,
    required this.sizeGroups,
    required this.sizeSelected,
    required this.colorSelected,
    required this.quantity,
  });
  @override
  List<Object> get props =>
      [productDetails, sizeGroups, sizeSelected, colorSelected, quantity];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});
  @override
  List<Object> get props => [];
}
