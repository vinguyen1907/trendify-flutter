import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RatingItem extends StatelessWidget {
  const RatingItem(
      {super.key, required this.isSelected, required this.value, this.onTap});
  final bool isSelected;
  final int value;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> listStars = List.generate(
        value,
        (index) => const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.star,
                color: Colors.orangeAccent,
              ),
            ));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: listStars,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: size.height * 0.03,
              width: size.height * 0.03,
              decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.primaryColor : AppColors.greyColor,
                  borderRadius: BorderRadius.circular(size.height * 0.03 / 2)),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 18,
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
