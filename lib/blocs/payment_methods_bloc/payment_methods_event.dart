part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsEvent extends Equatable {
  const PaymentMethodsEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethods extends PaymentMethodsEvent {}
