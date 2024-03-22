part of 'order_processing_bloc.dart';

sealed class OrderProcessingEvent extends Equatable {
  const OrderProcessingEvent();

  @override
  List<Object?> get props => [];
}

class AddOrder extends OrderProcessingEvent {
  final OrderModel order;
  final List<CartItem> items;
  final String cardNumber;
  final List<CartItem> cartItems;
  final Promotion? promotion;

  const AddOrder({
    required this.order,
    required this.items,
    required this.cardNumber,
    required this.cartItems,
    required this.promotion,
  });

  @override
  List<Object?> get props => [order, items, cardNumber, cartItems, promotion];
}

class ResetOrderProcessingState extends OrderProcessingEvent {}
