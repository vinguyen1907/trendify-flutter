import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHome>(_onLoadHome);
  }

  _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      final List<Promotion> promotions =
          await PromotionRepository().fetchValidPromotions();
      final List<Product> newArrivals =
          await ProductRepository().fetchNewArrivals();
      final List<Product> popular = await ProductRepository().fetchPopular();
      emit(HomeLoaded(
          promotions: promotions, popular: popular, newArrivals: newArrivals));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
