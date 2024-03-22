import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/config/app_routes.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/my_order_tab_selection_button.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/my_order_tab_selections.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/order_item_widget.dart';
import 'package:ecommerce_app/screens/order_tracking_screen/order_tracking_screen.dart';
import 'package:ecommerce_app/screens/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  static const routeName = "/my-order-screen";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  MyOrderTabSelections _selection = MyOrderTabSelections.ongoing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          actions: [
            IconButton(
                onPressed: _navigateToQrScannerScreen,
                icon: MyIcon(
                  icon: AppAssets.icScanQr,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ))
          ],
        ),
        body: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                ScreenNameSection(
                    label: AppLocalizations.of(context)!.myOrders),
                const Spacer(),
                const SizedBox(width: 10),
                MyOrderTabSelectionButton(
                    label: AppLocalizations.of(context)!.ongoing,
                    isSelected: _selection == MyOrderTabSelections.ongoing,
                    onPressed: () {
                      setState(() {
                        _selection = MyOrderTabSelections.ongoing;
                      });
                    }),
                const SizedBox(width: 10),
                MyOrderTabSelectionButton(
                    label: AppLocalizations.of(context)!.completed,
                    isSelected: _selection == MyOrderTabSelections.completed,
                    onPressed: () {
                      setState(() {
                        _selection = MyOrderTabSelections.completed;
                      });
                    }),
                const SizedBox(width: AppDimensions.defaultPadding),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<OrderModel>>(
                  future: OrderRepository().fetchMyOrders(
                    isCompleted: _selection == MyOrderTabSelections.completed,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CustomLoadingWidget();
                    } else {
                      final List<OrderModel> orders = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: orders.length,
                          itemBuilder: (_, index) {
                            final order = orders[index];
                            return StreamBuilder(
                                stream: OrderRepository()
                                    .streamOrderItem(orderId: order.id),
                                builder: (_, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  } else if (snapshot.hasData) {
                                    final List<OrderProductDetail> orderItems =
                                        snapshot.data!;
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: orderItems.length,
                                        itemBuilder: (_, index) {
                                          return OrderItemWidget(
                                              order: order,
                                              orderItem: orderItems[index],
                                              isComplete: _selection ==
                                                  MyOrderTabSelections
                                                      .completed,
                                              onTap: () =>
                                                  _navigateToOrderTrackingScreen(
                                                      context,
                                                      order,
                                                      orderItems[index]));
                                        });
                                  }
                                  return const SizedBox();
                                });
                          });
                    }
                  }),
            )
          ],
        ));
  }

  void _navigateToOrderTrackingScreen(
      BuildContext context, OrderModel order, OrderProductDetail orderItem) {
    Navigator.pushNamed(context, OrderTrackingScreen.routeName,
        arguments: OrderTrackingArguments(order: order, orderItem: orderItem));
  }

  void _navigateToQrScannerScreen() {
    Navigator.pushNamed(context, QrScannerScreen.routeName);
  }
}
