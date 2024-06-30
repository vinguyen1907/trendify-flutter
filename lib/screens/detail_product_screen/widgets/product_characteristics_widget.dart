import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

class ProductCharacteristicsWidget extends StatelessWidget {
  const ProductCharacteristicsWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Characteristics",
              style: AppStyles.headlineMedium,
            ),
          ),
          if (product.outerMaterial != null)
            Text(
              "Outer Material: ${product.outerMaterial}",
            ),
          if (product.innerMaterial != null) ...[
            const SizedBox(height: 5),
            Text(
              "Inner Material: ${product.innerMaterial}",
            ),
          ],
          if (product.sole != null) ...[
            const SizedBox(height: 5),
            Text(
              "Sole: ${product.sole}",
            ),
          ],
          if (product.closure != null) ...[
            const SizedBox(height: 5),
            Text(
              "Closure: ${product.closure}",
            ),
          ],
          if (product.heelType != null) ...[
            const SizedBox(height: 5),
            Text(
              "Heel Type: ${product.heelType}",
            ),
          ],
          if (product.heelHeight != null) ...[
            const SizedBox(height: 5),
            Text(
              "Heel Height: ${product.heelHeight}",
            ),
          ],
          if (product.shoeWidth != null) ...[
            const SizedBox(height: 5),
            Text(
              "Shoe Width: ${product.shoeWidth}",
            ),
          ],
        ],
      ),
    );
  }
}
