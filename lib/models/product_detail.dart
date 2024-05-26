class ProductDetail {
  final String? size;
  final String? color;
  final int stock;

  ProductDetail({
    required this.size,
    required this.color,
    required this.stock,
  });

  factory ProductDetail.fromMap(Map<String, dynamic> map) {
    return ProductDetail(
      size: map['size'].toString(),
      color: map['color'],
      stock: map['stock'],
    );
  }
}
