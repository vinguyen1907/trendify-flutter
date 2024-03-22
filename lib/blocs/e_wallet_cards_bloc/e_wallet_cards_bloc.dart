import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/e_wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'e_wallet_cards_event.dart';
part 'e_wallet_cards_state.dart';

class EWalletCardsBloc extends Bloc<EWalletCardsEvent, EWalletCardsState> {
  EWalletCardsBloc() : super(EWalletCardsInitial()) {
    on<LoadEWalletCards>(_onLoadEWalletCards);
  }

  _onLoadEWalletCards(
    LoadEWalletCards event,
    Emitter<EWalletCardsState> emit,
  ) async {
    emit(EWalletCardsLoading());
    try {
      final List<PaymentInformation> eWalletCards =
          await EWalletRepository().fetchEWalletCards();

      emit(EWalletCardsLoaded(eWalletCards: eWalletCards));
    } catch (e) {
      emit(EWalletCardsError(message: e.toString()));
    }
  }
}
