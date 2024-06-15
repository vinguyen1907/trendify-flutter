part of 'order_tracking_bloc.dart';

abstract class OrderTrackingEvent extends Equatable {
  const OrderTrackingEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderTracking extends OrderTrackingEvent {
  final String orderId;

  const LoadOrderTracking({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
