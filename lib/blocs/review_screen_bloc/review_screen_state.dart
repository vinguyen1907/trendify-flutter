part of 'review_screen_bloc.dart';

abstract class ReviewScreenState extends Equatable {
  const ReviewScreenState();
}

class ReviewScreenInitial extends ReviewScreenState {
  @override
  List<Object> get props => [];
}

class ReviewScreenLoading extends ReviewScreenState {
  @override
  List<Object> get props => [];
}

class ReviewScreenLoaded extends ReviewScreenState {
  final List<Review> reviews;

  const ReviewScreenLoaded({required this.reviews});
  @override
  List<Object> get props => [];
}

class ReviewScreenError extends ReviewScreenState {
  final String message;

  const ReviewScreenError({required this.message});
  @override
  List<Object> get props => [];
}
