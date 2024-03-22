part of 'e_wallet_transactions_bloc.dart';

sealed class EWalletTransactionsState extends Equatable {
  const EWalletTransactionsState({
    required this.lastDocument,
  });
  final DocumentSnapshot? lastDocument;

  @override
  List<Object?> get props => [lastDocument];
}

final class EWalletTransactionsInitial extends EWalletTransactionsState {
  const EWalletTransactionsInitial() : super(lastDocument: null);
}

final class EWalletTransactionsLoading extends EWalletTransactionsState {
  const EWalletTransactionsLoading() : super(lastDocument: null);
}

final class EWalletTransactionsLoaded extends EWalletTransactionsState {
  final List<EWalletTransaction> eWalletTransactions;

  const EWalletTransactionsLoaded({
    required this.eWalletTransactions,
    required super.lastDocument,
  });

  @override
  List<Object?> get props => [eWalletTransactions, lastDocument];
}

final class EWalletTransactionsError extends EWalletTransactionsState {
  final String message;

  const EWalletTransactionsError({required this.message})
      : super(lastDocument: null);

  @override
  List<Object> get props => [message];
}
