import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';

import '../../models/models.dart';

part 'order_processing_event.dart';
part 'order_processing_state.dart';

class OrderProcessingBloc
    extends Bloc<OrderProcessingEvent, OrderProcessingState> {
  final IOrderRepository _orderRepository = GetIt.I<IOrderRepository>(); 

  OrderProcessingBloc() : super(OrderProcessingInitial()) {
    on<AddOrder>(_onAddOrder);
    on<ResetOrderProcessingState>(_onResetOrderProcessingState);
  }

  void _onAddOrder(AddOrder event, Emitter<OrderProcessingState> emit) async {
    emit(OrderProcessingAdding());
    try {
      final String orderId = await _orderRepository.addOrder(
          order: event.order, items: event.items, promotion: event.promotion);

      // if (event.order.paymentMethod == PaymentMethods.eWallet.code) {
      //   await EWalletRepository().payOrder(
      //       paymentTransaction: PaymentTransaction(
      //           id: "",
      //           type: EWalletTransactionType.payment,
      //           createdTime: DateTime.now(),
      //           cardNumber: event.cardNumber,
      //           items: event.cartItems,
      //           amount: event.order.orderSummary.amount,
      //           promotionAmount: event.order.orderSummary.promotionDiscount,
      //           shippingFee: event.order.orderSummary.shipping));
      // }

      final order = event.order.copyWith(id: orderId);
      emit(OrderProcessingSuccessfully(order: order));
    } catch (e) {
      emit(OrderProcessingFailed(message: e.toString()));
    }
  }

  _onResetOrderProcessingState(event, emit) {
    emit(OrderProcessingInitial());
  }
}
