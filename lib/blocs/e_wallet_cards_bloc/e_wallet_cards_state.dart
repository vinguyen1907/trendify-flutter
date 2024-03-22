part of 'e_wallet_cards_bloc.dart';

sealed class EWalletCardsState extends Equatable {
  const EWalletCardsState();

  @override
  List<Object> get props => [];
}

final class EWalletCardsInitial extends EWalletCardsState {}

final class EWalletCardsLoading extends EWalletCardsState {}

final class EWalletCardsLoaded extends EWalletCardsState {
  final List<PaymentInformation> eWalletCards;

  const EWalletCardsLoaded({required this.eWalletCards});

  @override
  List<Object> get props => [eWalletCards];
}

final class EWalletCardsError extends EWalletCardsState {
  final String message;

  const EWalletCardsError({required this.message});

  @override
  List<Object> get props => [message];
}
