import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/promotion_models/promotion.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProductRepository _productRepository = GetIt.I.get<IProductRepository>();
  HomeBloc() : super(HomeInitial()) {
    on<LoadHome>(_onLoadHome);
  }

  _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      final List<Promotion> promotions = [];
      // final List<Promotion> promotions =
      //     await PromotionRepository().fetchValidPromotions();
      final List<Product> newArrivals = await _productRepository.fetchRecommendedProducts();
      final List<Product> popular = [];
      // final List<Product> popular = await ProductRepository().fetchPopular();
      emit(HomeLoaded(promotions: promotions, popular: popular, newArrivals: newArrivals));
    } catch (e) {
      debugPrint("Home bloc error: $e");
      emit(HomeError(message: e.toString()));
    }
  }
}
