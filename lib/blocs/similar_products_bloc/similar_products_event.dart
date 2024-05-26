import 'package:equatable/equatable.dart';

abstract class SimilarProductEvent extends Equatable {
  const SimilarProductEvent();
}

class LoadSimilarProducts extends SimilarProductEvent {
  final String productCode;
  const LoadSimilarProducts({required this.productCode});
  @override
  List<Object> get props => [productCode];
}
