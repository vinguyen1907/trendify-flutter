part of 'review_screen_bloc.dart';

abstract class ReviewScreenEvent extends Equatable {
  const ReviewScreenEvent();
}

class LoadReviews extends ReviewScreenEvent {
  const LoadReviews({required this.productId});
  final String productId;
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
