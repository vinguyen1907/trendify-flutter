import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/repositories/e_wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'e_wallet_transactions_event.dart';
part 'e_wallet_transactions_state.dart';

class EWalletTransactionsBloc
    extends Bloc<EWalletTransactionsEvent, EWalletTransactionsState> {
  EWalletTransactionsBloc() : super(EWalletTransactionsInitial()) {
    on<LoadEWalletTransactions>(_onLoadEWalletTransactions);
    on<ReloadEWalletTransactions>(_onReloadEWalletTransactions);
    on<LoadMoreEWalletTransactions>(_onLoadMoreEWalletTransactions);
  }

  _onLoadEWalletTransactions(LoadEWalletTransactions event,
      Emitter<EWalletTransactionsState> emit) async {
    emit(const EWalletTransactionsLoading());
    try {
      final transactions = await EWalletRepository().fetchTransactions();
      emit(EWalletTransactionsLoaded(
          eWalletTransactions: transactions['transactions'],
          lastDocument: transactions['lastDocument']));
    } catch (e) {
      emit(EWalletTransactionsError(message: e.toString()));
    }
  }

  _onReloadEWalletTransactions(ReloadEWalletTransactions event,
      Emitter<EWalletTransactionsState> emit) async {
    try {
      final transactions = await EWalletRepository().fetchTransactions();
      emit(EWalletTransactionsLoaded(
          eWalletTransactions: transactions['transactions'],
          lastDocument: transactions['lastDocument']));
    } catch (e) {
      emit(EWalletTransactionsError(message: e.toString()));
    }
  }

  _onLoadMoreEWalletTransactions(LoadMoreEWalletTransactions event,
      Emitter<EWalletTransactionsState> emit) async {
    try {
      final newTransactions = await EWalletRepository()
          .fetchTransactions(lastDocument: state.lastDocument);
      if (state is EWalletTransactionsLoaded) {
        final transactions =
            (state as EWalletTransactionsLoaded).eWalletTransactions;
        transactions.addAll(
            newTransactions['transactions'] as List<EWalletTransaction>);

        emit(EWalletTransactionsLoaded(
            eWalletTransactions: transactions,
            lastDocument: newTransactions['lastDocument']));
      }
    } catch (e) {
      emit(EWalletTransactionsError(message: e.toString()));
    }
  }
}
