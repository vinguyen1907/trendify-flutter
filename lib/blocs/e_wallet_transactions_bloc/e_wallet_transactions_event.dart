part of 'e_wallet_transactions_bloc.dart';

sealed class EWalletTransactionsEvent extends Equatable {
  const EWalletTransactionsEvent();

  @override
  List<Object> get props => [];
}

final class LoadEWalletTransactions extends EWalletTransactionsEvent {}

final class ReloadEWalletTransactions extends EWalletTransactionsEvent {}

final class LoadMoreEWalletTransactions extends EWalletTransactionsEvent {}
