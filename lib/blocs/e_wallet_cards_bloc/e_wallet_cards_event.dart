part of 'e_wallet_cards_bloc.dart';

sealed class EWalletCardsEvent extends Equatable {
  const EWalletCardsEvent();

  @override
  List<Object> get props => [];
}

class LoadEWalletCards extends EWalletCardsEvent {}
