import 'package:ecommerce_app/router/arguments/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/order_item_widget.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  static const String routeName = "/order-tracking-screen";

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late final OrderModel order;
  late final OrderProductDetail? orderItem;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is OrderTrackingScreenArgs) {
        order = args.order;
        orderItem = args.orderItem;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.orderNumber, style: Theme.of(context).textTheme.headlineLarge),
            Text("Washington - Geiorgia", style: Theme.of(context).textTheme.bodyMedium),
            if (orderItem != null) OrderItemWidget(margin: const EdgeInsets.symmetric(vertical: 20), order: order, orderItem: orderItem!),
            // const SizedBox(height: 10),
            // const SectionLabel(
            //   label: "Collection Point",
            //   margin: EdgeInsets.only(bottom: 8),
            // ),
            // const Text("10:11-11:00 - 25 June, 2021",
            //     style: AppStyles.bodyLarge),
            // Text("${order.address.street}, ${order.address.country}",
            //     style: AppStyles.bodyLarge),
            // const SizedBox(height: 8),
            // const Divider(color: AppColors.greyColor),
            // Row(
            //   children: [
            //     const Expanded(
            //       child: Text(
            //           "You can change pick-up time for your order by 10:00, 24 June",
            //           style: AppStyles.bodyLarge),
            //     ),
            //     const SizedBox(width: 30),
            //     MyButton(
            //         borderRadius: 8,
            //         onPressed: () {},
            //         padding: const EdgeInsets.all(8),
            //         child: Text(
            //           "Change",
            //           style: AppStyles.bodyMedium.copyWith(
            //               color: AppColors.whiteColor,
            //               fontWeight: FontWeight.w600),
            //         )),
            //   ],
            // ),
            SectionLabel(
              label: AppLocalizations.of(context)!.history,
              margin: const EdgeInsets.only(bottom: 8, top: 10),
            ),
            FutureBuilder<List<TrackingStatus>>(
              future: OrderRepository().fetchTrackingStatus(orderId: order.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoadingWidget();
                }

                final List<TrackingStatus> statuses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: statuses.length,
                  itemBuilder: (_, index) {
                    final status = statuses[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${status.createAt.getMonth()} ${status.createAt.toDate().day}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text("${status.createAt.toDate().hour}:${status.createAt.toDate().minute}",
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 10,
                              width: 10,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).colorScheme.primaryContainer),
                            ),
                            if (index < statuses.length - 1)
                              Container(
                                height: 50,
                                width: 3,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).colorScheme.primaryContainer),
                              ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${trackingStatusTitle[status.status]}",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              if (status.currentLocation != null) Text("${status.currentLocation}", style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
