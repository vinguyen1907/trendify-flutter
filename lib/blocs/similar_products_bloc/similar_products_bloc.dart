import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/interfaces/product_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'similar_products_event.dart';
import 'similar_products_state.dart';

class SimilarProductsBloc extends Bloc<SimilarProductEvent, SimilarProductsState> {
  final IProductRepository _productRepository = GetIt.I.get<IProductRepository>();

  SimilarProductsBloc() : super(SimilarProductsInitial()) {
    on<LoadSimilarProducts>(_onLoadProductDetails);
  }

  _onLoadProductDetails(LoadSimilarProducts event, emit) async {
    try {
      emit(SimilarProductsLoading());
      final List<Product> similarProducts = await _productRepository.fetchSimilarProducts(event.productCode);
      emit(SimilarProductsLoaded(similarProducts: similarProducts));
    } catch (e) {
      print("Load similar products Bloc error: $e");
      emit(SimilarProductsError(message: e.toString()));
    }
  }
}
