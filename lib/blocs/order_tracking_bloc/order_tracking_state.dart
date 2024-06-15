part of 'order_tracking_bloc.dart';

abstract class OrderTrackingState extends Equatable {
  const OrderTrackingState();

  @override
  List<Object> get props => [];
}

class OrderTrackingInitial extends OrderTrackingState {}

class OrderTrackingLoading extends OrderTrackingState {}

class OrderTrackingLoaded extends OrderTrackingState {
  final List<OrderProductDetail> orderItems;

  const OrderTrackingLoaded({required this.orderItems});

  @override
  List<Object> get props => [orderItems];
}

class OrderTrackingError extends OrderTrackingState {
  final String message;

  const OrderTrackingError({required this.message});

  @override
  List<Object> get props => [message];
}
