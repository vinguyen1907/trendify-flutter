part of 'my_orders_bloc.dart';

enum MyOrderStateEnum {
  initial,
  loading,
  loaded,
  error,
}

class MyOrdersState extends Equatable {
  final MyOrderStateEnum stateEnum;
  final MyOrderTabSelections selection;
  final List<OrderModel>? ongoingOrders;
  final List<OrderModel>? completedOrders;
  final String? message;

  const MyOrdersState({
    required this.stateEnum,
    required this.selection,
    this.ongoingOrders,
    this.completedOrders,
    this.message,
  });

  MyOrdersState copyWith(
      {MyOrderStateEnum? stateEnum,
      MyOrderTabSelections? selection,
      List<OrderModel>? ongoingOrders,
      List<OrderModel>? completedOrders,
      String? message}) {
    return MyOrdersState(
      stateEnum: stateEnum ?? this.stateEnum,
      selection: selection ?? this.selection,
      ongoingOrders: ongoingOrders ?? this.ongoingOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        stateEnum,
        selection,
        ongoingOrders,
        completedOrders,
        message,
      ];
}
