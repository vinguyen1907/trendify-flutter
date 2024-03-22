part of 'order_processing_bloc.dart';

sealed class OrderProcessingState extends Equatable {
  const OrderProcessingState();

  @override
  List<Object> get props => [];
}

final class OrderProcessingInitial extends OrderProcessingState {}

final class OrderProcessingAdding extends OrderProcessingState {}

final class OrderProcessingSuccessfully extends OrderProcessingState {
  final OrderModel order;

  const OrderProcessingSuccessfully({required this.order});

  @override
  List<Object> get props => [order];
}

final class OrderProcessingFailed extends OrderProcessingState {
  final String message;

  const OrderProcessingFailed({required this.message});

  @override
  List<Object> get props => [message];
}
