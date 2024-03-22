// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_order_bloc.dart';

sealed class PlaceOrderEvent extends Equatable {
  const PlaceOrderEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAddress extends PlaceOrderEvent {
  final ShippingAddress? address;

  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdatePromotion extends PlaceOrderEvent {
  final Promotion promotion;
  const UpdatePromotion(this.promotion);

  @override
  List<Object?> get props => [promotion];
}

class UpdatePrice extends PlaceOrderEvent {
  final double totalPrice;
  const UpdatePrice(this.totalPrice);

  @override
  List<Object?> get props => [totalPrice];
}

class UpdatePaymentInformation extends PlaceOrderEvent {
  final PaymentInformation? paymentInformation;
  final PaymentMethodResource? paymentMethod;
  const UpdatePaymentInformation({
    this.paymentInformation,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [paymentInformation, paymentMethod];
}

class GetBill extends PlaceOrderEvent {
  final Cart cart;
  const GetBill({required this.cart});

  @override
  List<Object?> get props => [cart];
}

class ReloadBill extends PlaceOrderEvent {}
