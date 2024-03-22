part of 'show_notification_bloc.dart';

abstract class ShowNotificationEvent extends Equatable {
  const ShowNotificationEvent();
}

class ShowAddToCartSuccess extends ShowNotificationEvent {
  const ShowAddToCartSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShowUndoAddToCartSuccess extends ShowNotificationEvent {
  const ShowUndoAddToCartSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
