import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategory>(_onLoadCategories);
    on<SearchCategory>(_onSearchCategories);
  }
  _onLoadCategories(LoadCategory event, Emitter emit) async {
    try {
      emit(CategoryLoading());
      final List<Category> categories =
          await CategoryRepository().fetchCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  _onSearchCategories(SearchCategory event, Emitter emit) async {
    try {
      final List<Category> categories =
          await CategoryRepository().fetchCategories();
      final List<Category> searchCategories = [];
      final String query = event.query;
      if (query.isNotEmpty) {
        searchCategories.addAll(categories
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList());
      } else {
        searchCategories.addAll(categories);
      }
      emit(CategoryLoaded(categories: searchCategories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
