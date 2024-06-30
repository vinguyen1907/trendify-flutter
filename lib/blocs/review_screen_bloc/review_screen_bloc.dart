import 'dart:async';
import 'package:ecommerce_app/models/review.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'review_screen_event.dart';
part 'review_screen_state.dart';

class ReviewScreenBloc extends Bloc<ReviewScreenEvent, ReviewScreenState> {
  final IReviewRepository _reviewRepository = GetIt.I.get<IReviewRepository>();

  ReviewScreenBloc() : super(ReviewScreenInitial()) {
    on<LoadReviews>(_onLoadReviews);
  }

  FutureOr<void> _onLoadReviews(LoadReviews event, Emitter<ReviewScreenState> emit) async {
    try {
      emit(ReviewScreenLoading());
      final List<Review> reviews = await _reviewRepository.fetchReviews(event.productId);
      emit(ReviewScreenLoaded(reviews: reviews));
    } catch (e) {
      emit(ReviewScreenError(message: e.toString()));
    }
  }
}
