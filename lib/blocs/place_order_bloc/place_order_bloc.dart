import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/models/payment_method_resource.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:equatable/equatable.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(const PlaceOrderState()) {
    on<UpdateAddress>(_onUpdateAddress);
    on<UpdatePromotion>(_onUpdatePromotion);
    on<UpdatePrice>(_onUpdatePrice);
    on<UpdatePaymentInformation>(_onUpdatePaymentInformation);
    on<GetBill>(_onGetBill);
    on<ReloadBill>(_onReloadBill);
  }

  void _onUpdateAddress(UpdateAddress event, Emitter<PlaceOrderState> emit) {
    emit(state.copyWith(address: event.address));
  }

  void _onUpdatePromotion(event, emit) {
    emit(state.copyWith(promotion: event.promotion));
  }

  void _onUpdatePrice(event, emit) {
    emit(state.copyWith(totalPrice: event.totalPrice));
  }

  void _onUpdatePaymentInformation(UpdatePaymentInformation event, emit) {
    emit(state.copyWith(
        paymentInformation: event.paymentInformation,
        paymentMethod: event.paymentMethod));
  }

  void _onGetBill(event, emit) {
    final Cart cart = event.cart;
    final double amount = cart.totalPrice;
    double shipping = state.defaultShipping;
    double promoDiscount = 0;

    if (state.promotion is FreeShippingPromotion) {
      shipping = 0;
    } else if (state.promotion is PercentagePromotion) {
      promoDiscount =
          amount * (state.promotion as PercentagePromotion).percentage / 100;
    } else if (state.promotion is FixedAmountPromotion) {
      promoDiscount = (state.promotion as FixedAmountPromotion).amount;
    } else {
      shipping = state.defaultShipping;
      promoDiscount = 0;
    }

    emit(state.copyWith(
      cart: cart,
      amount: amount,
      shipping: shipping,
      promoDiscount: promoDiscount,
      totalPrice: amount + shipping - promoDiscount,
    ));
  }

  void _onReloadBill(event, emit) {
    final double amount = state.cart!.totalPrice;
    double shipping = state.defaultShipping;
    double promoDiscount = 0;

    if (state.promotion is FreeShippingPromotion) {
      shipping = 0;
    } else if (state.promotion is PercentagePromotion) {
      promoDiscount =
          amount * (state.promotion as PercentagePromotion).percentage / 100;
    } else if (state.promotion is FixedAmountPromotion) {
      promoDiscount = (state.promotion as FixedAmountPromotion).amount;
    } else {
      shipping = state.defaultShipping;
      promoDiscount = 0;
    }

    emit(state.copyWith(
      amount: amount,
      shipping: shipping,
      promoDiscount: promoDiscount,
      totalPrice: amount + shipping - promoDiscount,
    ));
  }
}
