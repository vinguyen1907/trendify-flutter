part of 'payment_methods_bloc.dart';

sealed class PaymentMethodsState extends Equatable {
  const PaymentMethodsState();

  @override
  List<Object> get props => [];
}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class PaymentMethodsLoading extends PaymentMethodsState {}

final class PaymentMethodsLoaded extends PaymentMethodsState {
  final List<PaymentInformation> paymentCards;
  const PaymentMethodsLoaded({required this.paymentCards});

  @override
  List<Object> get props => [paymentCards];
}

final class PaymentMethodsError extends PaymentMethodsState {
  final String message;
  const PaymentMethodsError(this.message);

  @override
  List<Object> get props => [message];
}
