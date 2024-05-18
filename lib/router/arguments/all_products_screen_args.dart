// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/models.dart';

class AllProductsScreenArgs {
  final List<Product> products;
  final String sectionName;

  AllProductsScreenArgs({
    required this.products,
    required this.sectionName,
  });
}
