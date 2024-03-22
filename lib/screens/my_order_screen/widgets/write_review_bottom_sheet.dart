import 'package:ecommerce_app/common_widgets/color_dot_widget.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewBottomSheet extends StatefulWidget {
  const WriteReviewBottomSheet({
    super.key,
    required this.orderItem,
    required this.onAddReview,
  });
  final OrderProductDetail orderItem;
  final Function(int, String?) onAddReview;

  @override
  State<WriteReviewBottomSheet> createState() => _WriteReviewBottomSheetState();
}

class _WriteReviewBottomSheetState extends State<WriteReviewBottomSheet> {
  double rating = 5;
  bool isLoading = false;
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return LoadingManager(
      isLoading: isLoading,
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          final double bottomSheetBottomPadding =
              isKeyboardVisible ? size.height * 0.3 : 0;

          return Container(
              // height: size.height * 0.7,
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20))),
              padding: EdgeInsets.only(
                  left: AppDimensions.defaultPadding,
                  right: AppDimensions.defaultPadding,
                  bottom: bottomSheetBottomPadding),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 10),
                  Container(height: 5, width: 40, color: AppColors.greyColor),
                  const SizedBox(height: 10),
                  Text(
                    "Leave a Review",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.greyColor),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.orderItem.productImgUrl,
                          height: size.width * 0.21,
                          width: size.width * 0.21,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderItem.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            if (widget.orderItem.productBrand.isNotEmpty)
                              Text(
                                widget.orderItem.productBrand,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            Row(
                              children: [
                                Text(
                                  "Quantity: ${widget.orderItem.quantity}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Size: ${widget.orderItem.size}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Color: ",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                ColorDotWidget(
                                    color: widget.orderItem.color.toColor())
                              ],
                            ),
                            Text(
                              widget.orderItem.productPrice.toPriceString(),
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.greyColor),
                  const SizedBox(height: 10),
                  Text("How is your order?",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Text("Please give your rating & also your review...",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 10),
                  RatingBar(
                    itemCount: 5,
                    maxRating: 5,
                    initialRating: 5,
                    allowHalfRating: false,
                    itemSize: 30,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                    ratingWidget: RatingWidget(
                      full: const MyIcon(icon: AppAssets.icStarBold),
                      half: const MyIcon(icon: AppAssets.icStarBold),
                      empty: const MyIcon(icon: AppAssets.icStar),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: contentController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      hintText: "Write your review here...",
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const MyIcon(icon: AppAssets.icGallery)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MyButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: AppColors.greyColor,
                            child: Text("Cancel",
                                style: Theme.of(context).textTheme.labelLarge)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyButton(
                            onPressed: () async {
                              await _onAddReview();
                            },
                            child: Text("Submit",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.whiteColor))),
                      )
                    ],
                  ),
                  SizedBox(height: bottomSheetBottomPadding),
                ]),
              ));
        },
      ),
    );
  }

  Future<void> _onAddReview() async {
    setState(() {
      isLoading = true;
    });
    await widget.onAddReview(rating.toInt(), contentController.text);
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    Navigator.pop(context);
  }
}
