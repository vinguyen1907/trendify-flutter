import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/models/product_detail.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/color_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorBar extends StatefulWidget {
  const ColorBar({super.key});

  @override
  State<ColorBar> createState() => _ColorBarState();
}

class _ColorBarState extends State<ColorBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final currentState = state as ProductLoaded;
        final List<ProductDetail> listProductDetails =
            currentState.sizeGroups[currentState.sizeSelected]!
              ..sort(
                (a, b) =>
                    int.parse(a.color!.substring(1, 7), radix: 16) -
                    int.parse(b.color!.substring(1, 7), radix: 16),
              );
        List<ColorItem> items = List.generate(
            listProductDetails.length,
            (index) => ColorItem(
                  onTap: () {
                    context.read<ProductBloc>().add(
                        ChooseColor(color: listProductDetails[index].color!));
                  },
                  color: listProductDetails[index].color!,
                  isSelected: listProductDetails[index].color ==
                      currentState.colorSelected,
                  padding: const EdgeInsets.all(0),
                ));
        if (listProductDetails.length > 4) {
          return Container(
            width: size.width * 0.35,
            height: size.width * 0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.12 / 2),
                border: Border.all(width: 1, color: AppColors.greyColor)),
            child: Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                SizedBox(
                  height: size.width * 0.06,
                  width: size.width * 0.06 * 4 + 4 * 3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listProductDetails.length,
                    itemBuilder: (context, index) {
                      return ColorItem(
                        color: listProductDetails[index].color!,
                        isSelected: false,
                        padding: const EdgeInsets.only(right: 4),
                      );
                    },
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                ),
              ],
            ),
          );
        } else {
          return Container(
            width: size.width * 0.35,
            height: size.width * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.12 / 2),
                border: Border.all(width: 1, color: AppColors.greyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: items,
            ),
          );
        }
      },
    );
  }
}
