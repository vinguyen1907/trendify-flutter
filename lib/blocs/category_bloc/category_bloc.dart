import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository categoryRepository = GetIt.I.get<ICategoryRepository>();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategory>(_onLoadCategories);
    on<SearchCategory>(_onSearchCategories);
  }
  _onLoadCategories(LoadCategory event, Emitter emit) async {
    try {
      emit(CategoryLoading());
      final List<Category> categories =
          await categoryRepository.fetchCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }

  _onSearchCategories(SearchCategory event, Emitter emit) async {
    try {
      final String query = event.query;
      final List<Category> searchCategories = await categoryRepository.searchCategories(query);
      // final List<Category> searchCategories = [];
      // if (query.isNotEmpty) {
      //   searchCategories.addAll(categories
      //       .where((element) =>
      //           element.name.toLowerCase().contains(query.toLowerCase()))
      //       .toList());
      // } else {
      //   searchCategories.addAll(categories);
      // }
      emit(CategoryLoaded(categories: searchCategories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
