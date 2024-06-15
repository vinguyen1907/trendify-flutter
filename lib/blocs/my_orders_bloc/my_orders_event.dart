part of 'my_orders_bloc.dart';

sealed class MyOrdersEvent extends Equatable {
  const MyOrdersEvent();

  @override
  List<Object> get props => [];
}

final class FetchMyOrders extends MyOrdersEvent {}

final class RefreshMyOrders extends MyOrdersEvent {}

final class ChangeMyOrderTabSelection extends MyOrdersEvent {
  final MyOrderTabSelections selection;

  const ChangeMyOrderTabSelection(this.selection);

  @override
  List<Object> get props => [selection];
}
