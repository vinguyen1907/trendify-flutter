part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHome extends HomeEvent {
  const LoadHome();

  @override
  List<Object?> get props => [];
}

class LoadMoreRecommendedProducts extends HomeEvent {
  const LoadMoreRecommendedProducts();
  @override
  List<Object?> get props => [];
}
