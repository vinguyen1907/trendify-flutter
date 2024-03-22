part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductDetails extends ProductEvent {
  const LoadProductDetails({required this.product});
  final Product product;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChooseSize extends ProductEvent {
  const ChooseSize({required this.size});
  final String size;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChooseColor extends ProductEvent {
  const ChooseColor({required this.color});
  final String color;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IncreaseQuantity extends ProductEvent {
  const IncreaseQuantity();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DecreaseQuantity extends ProductEvent {
  const DecreaseQuantity();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCart extends ProductEvent {
  const AddToCart();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UndoAddToCart extends ProductEvent {
  const UndoAddToCart();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
