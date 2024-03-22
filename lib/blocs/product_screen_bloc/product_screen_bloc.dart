import 'package:ecommerce_app/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_screen_event.dart';
part 'product_screen_state.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  ProductScreenBloc() : super(ProductScreenInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProduct>(_onSearchProduct);
  }
  List<Product> originalList = [];
  _onLoadProducts(LoadProducts event, Emitter<ProductScreenState> emit) {
    emit(ProductScreenLoading());
    originalList = List.from(event.products);
    emit(ProductScreenLoaded(
        sectionName: event.sectionName, products: event.products));
  }

  _onSearchProduct(SearchProduct event, Emitter<ProductScreenState> emit) {
    try {
      final currentState = state as ProductScreenLoaded;
      List<Product> resultProducts;
      if (event.query.isNotEmpty) {
        resultProducts = originalList
            .where((element) => element.name
                .toLowerCase()
                .toString()
                .contains(event.query.toLowerCase().toString()))
            .toList();
        emit(ProductScreenLoaded(
            sectionName: currentState.sectionName, products: resultProducts));
      } else {
        resultProducts = List.from(originalList);
        emit(ProductScreenLoaded(
            products: resultProducts, sectionName: currentState.sectionName));
      }
    } catch (e) {
      emit(ProductScreenError(message: e.toString()));
    }
  }
}
