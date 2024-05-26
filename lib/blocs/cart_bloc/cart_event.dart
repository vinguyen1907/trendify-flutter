part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class RemoveItem extends CartEvent {
  final String cartItemId;

  const RemoveItem({required this.cartItemId});

  @override
  List<Object> get props => [cartItemId];
}

class UpdateItem extends CartEvent {
  final String cartItemId;
  final int quantity;

  const UpdateItem({required this.cartItemId, required this.quantity});

  @override
  List<Object> get props => [cartItemId, quantity];
}

class UpdateCart extends CartEvent {
  final Cart cart;

  const UpdateCart({required this.cart});

  @override
  List<Object> get props => [cart];
}

class InitConnection extends CartEvent {
  final Function(Cart) updateCart;

  const InitConnection({required this.updateCart});

  @override
  List<Object> get props => [updateCart];
}
