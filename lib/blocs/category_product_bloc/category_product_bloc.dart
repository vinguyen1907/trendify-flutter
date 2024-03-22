import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  CategoryProductBloc() : super(CategoryProductInitial()) {
    on<LoadProductsInCategory>(_onLoadProductsInCategory);
    on<SearchProducts>(_onSearchProducts);
  }
  List<Product> originalList = [];
  _onLoadProductsInCategory(LoadProductsInCategory event, Emitter emit) async {
    try {
      emit(CategoryProductLoading());
      final Category category = event.category;
      final List<Product> products =
          await ProductRepository().fetchProductInCategory(category);
      originalList = List.from(products);
      emit(CategoryProductLoaded(products: products));
    } catch (e) {
      emit(CategoryProductError(message: e.toString()));
    }
  }

  _onSearchProducts(SearchProducts event, Emitter<CategoryProductState> emit) {
    List<Product> resultProducts;
    if (event.query.isNotEmpty) {
      resultProducts = originalList
          .where((element) => element.name
              .toLowerCase()
              .toString()
              .contains(event.query.toLowerCase().toString()))
          .toList();
    } else {
      resultProducts = List.from(originalList);
    }
    emit(CategoryProductLoaded(products: resultProducts));
  }
}
