import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'show_notification_event.dart';
part 'show_notification_state.dart';

class ShowNotificationBloc
    extends Bloc<ShowNotificationEvent, ShowNotificationState> {
  ShowNotificationBloc() : super(ShowNotificationInitial()) {
    on<ShowAddToCartSuccess>(_onShowAddToCartSuccess);
    on<ShowUndoAddToCartSuccess>(_onShowUndoAddToCartSuccess);
  }

  _onShowAddToCartSuccess(
      ShowAddToCartSuccess event, Emitter<ShowNotificationState> emit) {
    emit(AddToCartSuccess());
    emit(ShowNotificationInitial());
  }

  _onShowUndoAddToCartSuccess(
      ShowUndoAddToCartSuccess event, Emitter<ShowNotificationState> emit) {
    emit(UndoAddToCartSuccess());
    emit(ShowNotificationInitial());
  }
}
