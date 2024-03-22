// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_order_bloc.dart';

class PlaceOrderState extends Equatable {
  final ShippingAddress? address;
  final Promotion? promotion;
  final PaymentMethodResource? paymentMethod;
  final PaymentInformation? paymentInformation;
  final double defaultShipping;
  final Cart? cart;
  final double? amount;
  final double? shipping;
  final double? promoDiscount;
  final double? totalPrice;

  const PlaceOrderState({
    this.address,
    this.promotion,
    this.paymentMethod,
    this.paymentInformation,
    this.defaultShipping = 15,
    this.cart,
    this.amount,
    this.shipping,
    this.promoDiscount,
    this.totalPrice,
  });

  @override
  List<Object?> get props => [
        address,
        promotion,
        paymentMethod,
        paymentInformation,
        defaultShipping,
        cart,
        amount,
        shipping,
        promoDiscount,
        totalPrice,
      ];

  PlaceOrderState copyWith({
    ShippingAddress? address,
    Promotion? promotion,
    PaymentMethodResource? paymentMethod,
    PaymentInformation? paymentInformation,
    double? defaultShipping,
    Cart? cart,
    double? amount,
    double? shipping,
    double? promoDiscount,
    double? totalPrice,
  }) {
    return PlaceOrderState(
      address: address ?? this.address,
      promotion: promotion ?? this.promotion,
      paymentMethod: paymentMethod,
      paymentInformation: paymentInformation ?? this.paymentInformation,
      defaultShipping: defaultShipping ?? this.defaultShipping,
      cart: cart ?? this.cart,
      amount: amount ?? this.amount,
      shipping: shipping ?? this.shipping,
      promoDiscount: promoDiscount ?? this.promoDiscount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
