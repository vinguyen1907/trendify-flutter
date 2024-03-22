part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Promotion> promotions;
  final List<Product> newArrivals;
  final List<Product> popular;

  const HomeLoaded(
      {required this.promotions,
      required this.newArrivals,
      required this.popular});
  @override
  List<Object> get props => [promotions, newArrivals, popular];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}
