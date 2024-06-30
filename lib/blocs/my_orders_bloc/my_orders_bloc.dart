import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../screens/my_order_screen/widgets/my_order_tab_selections.dart';

part 'my_orders_event.dart';
part 'my_orders_state.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final IOrderRepository _orderRepository = GetIt.I<IOrderRepository>();

  MyOrdersBloc()
      : super(const MyOrdersState(
          stateEnum: MyOrderStateEnum.initial,
          selection: MyOrderTabSelections.ongoing,
        )) {
    on<FetchMyOrders>(_onFetchMyOrders);
    on<ChangeMyOrderTabSelection>(_onChangeMyOrderTabSelection);
  }
  _onFetchMyOrders(event, emit) async {
    try {
      emit(state.copyWith(stateEnum: MyOrderStateEnum.loading));
      final orders = await _orderRepository.fetchMyOrders(isCompleted: false);
      emit(state.copyWith(stateEnum: MyOrderStateEnum.loaded, ongoingOrders: orders));
    } catch (e) {
      print("MyOrdersBloc - _onFetchMyOrders -- Error: ${e.toString()}");
      emit(state.copyWith(stateEnum: MyOrderStateEnum.error, message: e.toString()));
    }
  }

  _onChangeMyOrderTabSelection(ChangeMyOrderTabSelection event, Emitter<MyOrdersState> emit) async {
    emit(state.copyWith(selection: event.selection));
    // if (state.completedOrders != null) {
    //   return;
    // }
    emit(state.copyWith(stateEnum: MyOrderStateEnum.loading));
    try {
      final orders = await _orderRepository.fetchMyOrders(isCompleted: event.selection == MyOrderTabSelections.completed);
      if (event.selection == MyOrderTabSelections.ongoing) {
        emit(state.copyWith(stateEnum: MyOrderStateEnum.loaded, ongoingOrders: orders));
      } else {
        emit(state.copyWith(stateEnum: MyOrderStateEnum.loaded, completedOrders: orders));
      }
    } catch (e) {
      print("MyOrdersBloc - _onChangeMyOrderTabSelection -- Error: ${e.toString()}");
      emit(state.copyWith(stateEnum: MyOrderStateEnum.error, message: "Error: ${e.toString()}"));
    }
  }
}
