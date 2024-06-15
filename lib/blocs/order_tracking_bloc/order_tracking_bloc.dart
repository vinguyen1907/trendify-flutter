import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'order_tracking_event.dart';
part 'order_tracking_state.dart';

class OrderTrackingBloc extends Bloc<OrderTrackingEvent, OrderTrackingState> {
  final IOrderRepository _orderRepository = GetIt.I.get();

  OrderTrackingBloc() : super(OrderTrackingInitial()) {
    on<LoadOrderTracking>(_onLoadAddresses);
  }

  _onLoadAddresses(event, emit) async {
    emit(OrderTrackingLoading());
    try {
      final orderItems = await _orderRepository.fetchOrderItems(orderId: event.orderId);
      emit(OrderTrackingLoaded(orderItems: orderItems));
    } catch (e) {
      emit(OrderTrackingError(message: e.toString()));
    }
  }
}
