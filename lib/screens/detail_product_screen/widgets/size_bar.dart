import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/size_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeBar extends StatefulWidget {
  const SizeBar({super.key});

  @override
  State<SizeBar> createState() => _SizeBarState();
}

class _SizeBarState extends State<SizeBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final currentState = state as ProductLoaded;
        Iterable<String> allSizes = currentState.sizeGroups.keys;
        int visibleSizeCount = 3;
        return SizedBox(
          height: size.width * 0.12,
          width: size.width * 0.12 * 3 + 10 * 3 + 24,
          child: Row(
            children: [
              SizedBox(
                height: size.width * 0.12,
                width: size.width * 0.12 * 3 + 10 * 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allSizes.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return SizeItem(
                            onTap: () {
                              context.read<ProductBloc>().add(
                                  ChooseSize(size: allSizes.elementAt(index)));
                            },
                            value: allSizes.elementAt(index),
                            isSelected: currentState.sizeSelected ==
                                allSizes.elementAt(index));
                      },
                    );
                  },
                ),
              ),
              if (allSizes.length > visibleSizeCount)
                const Icon(Icons.chevron_right)
            ],
          ),
        );
      },
    );
  }
}
