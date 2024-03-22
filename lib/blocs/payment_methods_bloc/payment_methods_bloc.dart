import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_methods_event.dart';
part 'payment_methods_state.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  PaymentMethodsBloc() : super(PaymentMethodsInitial()) {
    on<LoadPaymentMethods>(_onLoadPaymentMethods);
  }

  _onLoadPaymentMethods(event, emit) async {
    emit(PaymentMethodsLoading());
    try {
      final List<PaymentInformation> cards =
          await PaymentRepository().fetchPaymentCards();
      emit(PaymentMethodsLoaded(paymentCards: cards));
    } catch (e) {
      emit(PaymentMethodsError(e.toString()));
    }
  }
}
