part of 'show_notification_bloc.dart';

abstract class ShowNotificationState extends Equatable {
  const ShowNotificationState();
}

class ShowNotificationInitial extends ShowNotificationState {
  @override
  List<Object> get props => [];
}

class AddToCartSuccess extends ShowNotificationState {
  @override
  List<Object> get props => [];
}

class UndoAddToCartSuccess extends ShowNotificationState {
  @override
  List<Object> get props => [];
}
