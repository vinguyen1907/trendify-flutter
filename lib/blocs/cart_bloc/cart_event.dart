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
