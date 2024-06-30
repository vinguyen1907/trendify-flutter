import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/order_status_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/widgets.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:get_it/get_it.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderModel order;
  final OrderProductDetail orderItem;
  final EdgeInsets margin;
  final VoidCallback? onTap;
  final bool isComplete;

  const OrderItemWidget({
    super.key,
    required this.order,
    required this.orderItem,
    this.margin = const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: 10),
    this.onTap,
    this.isComplete = false,
  });

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  Review? review;

  @override
  void initState() {
    super.initState();
    _fetchReview();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onTap,
      child: PrimaryBackground(
        margin: widget.margin,
        child: Row(
          children: [
            Column(
              children: [
                OrderStatusLabel(status: widget.order.currentOrderStatus),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.orderItem.productImgUrl ?? "",
                    height: size.width * 0.21,
                    width: size.width * 0.21,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.orderItem.productName != null)
                    Text(
                      widget.orderItem.productName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.labelMedium,
                    ),
                  if (widget.orderItem.productBrand != null && widget.orderItem.productBrand!.isNotEmpty)
                    Text(
                      widget.orderItem.productBrand!,
                      style: AppStyles.bodyLarge,
                    ),
                  Text(
                    "${AppLocalizations.of(context)!.quantity}: ${widget.orderItem.quantity}",
                    style: AppStyles.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.size}: ${widget.orderItem.size}",
                        style: AppStyles.bodyMedium,
                      ),
                      const SizedBox(width: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.color}: ",
                            style: AppStyles.bodyMedium,
                          ),
                          if (widget.orderItem.color != null) ColorDotWidget(color: widget.orderItem.color!.toColor())
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(height: 10),
                      if (widget.orderItem.productPrice != null)
                        Text(
                          widget.orderItem.productPrice!.toPriceString(),
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      const Spacer(),
                      if (widget.isComplete && review == null)
                        MyButton(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            onPressed: () => _onWriteReview(context),
                            child: Text(AppLocalizations.of(context)!.review,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                    ))),
                      if (widget.isComplete && review != null)
                        MyButton(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            onPressed: () => _onAddToCart(context),
                            child: Text(AppLocalizations.of(context)!.buyAgain,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.whiteColor,
                                    ))),
                    ],
                  )
                ],
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  void _onWriteReview(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (_) {
          return WriteReviewBottomSheet(
            orderItem: widget.orderItem,
            onAddReview: (rating, content) => _onAddReview(context: context, rating: rating, reviewContent: content),
          );
        });
  }

  Future<void> _onAddReview({required BuildContext context, required int rating, String? reviewContent}) async {
    final IReviewRepository reviewRepository = GetIt.I.get<IReviewRepository>();
    await reviewRepository.addReview(
      context: context,
      orderId: widget.order.id,
      orderItemId: widget.orderItem.id ?? "",
      productId: widget.orderItem.productId ?? "",
      rating: rating,
      content: reviewContent ?? "",
    );
    _fetchReview();
  }

  void _onAddToCart(BuildContext context) async {
    CartRepository()
        .addCartItem(
      productId: widget.orderItem.productId ?? "",
      size: widget.orderItem.size ?? "",
      color: widget.orderItem.color ?? "",
      quantity: 1,
    )
        .then((value) {
      context.read<CartBloc>().add(LoadCart());
      _showNotification(context);
    });
  }

  void _showNotification(BuildContext context) {
    Utils.showSnackBarSuccess(
      context: context,
      message: "The product has been added to cart.",
      title: "Success",
    );
  }

  Future<void> _fetchReview() async {
    if (widget.orderItem.id != null) {
      if (widget.orderItem.id != null) {
        final IReviewRepository reviewRepository = GetIt.I.get<IReviewRepository>();
        final review = await reviewRepository.fetchReviewByOrderItemId(widget.orderItem.id!);
        if (mounted) {
          setState(() {
            this.review = review;
          });
        }
      }
    }
  }
}
