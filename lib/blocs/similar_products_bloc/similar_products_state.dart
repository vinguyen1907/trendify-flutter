import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SimilarProductsState extends Equatable {
  const SimilarProductsState();
}

class SimilarProductsInitial extends SimilarProductsState {
  @override
  List<Object> get props => [];
}

class SimilarProductsLoading extends SimilarProductsState {
  @override
  List<Object> get props => [];
}

class SimilarProductsLoaded extends SimilarProductsState {
  final List<Product> similarProducts;
  const SimilarProductsLoaded({required this.similarProducts});
  @override
  List<Object> get props => [similarProducts];
}

class SimilarProductsError extends SimilarProductsState {
  final String message;
  const SimilarProductsError({required this.message});

  @override
  List<Object> get props => [message];
}
