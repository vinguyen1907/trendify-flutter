import 'package:ecommerce_app/screens/my_order_screen/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/router/arguments/arguments.dart';
import 'package:ecommerce_app/screens/screens.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  static const routeName = "/my-order-screen";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(FetchMyOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          IconButton(
            onPressed: _navigateToQrScannerScreen,
            icon: MyIcon(
              icon: AppAssets.icScanQr,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MyOrdersBloc, MyOrdersState>(
              builder: (context, state) {
                final stateEnum = state.stateEnum;
                final itemCount = state.selection == MyOrderTabSelections.ongoing ? state.ongoingOrders?.length : state.completedOrders?.length;
                final orders = state.selection == MyOrderTabSelections.ongoing ? state.ongoingOrders : state.completedOrders;
                print("Completed orders: ${state.completedOrders}");
                return Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        ScreenNameSection(label: AppLocalizations.of(context)!.myOrders),
                        const SizedBox(width: 10),
                        MyOrderTabSelectionButton(
                            label: AppLocalizations.of(context)!.ongoing,
                            isSelected: state.selection == MyOrderTabSelections.ongoing,
                            onPressed: () {
                              context.read<MyOrdersBloc>().add(const ChangeMyOrderTabSelection(MyOrderTabSelections.ongoing));
                            }),
                        const SizedBox(width: 10),
                        MyOrderTabSelectionButton(
                            label: AppLocalizations.of(context)!.completed,
                            isSelected: state.selection == MyOrderTabSelections.completed,
                            onPressed: () {
                              context.read<MyOrdersBloc>().add(const ChangeMyOrderTabSelection(MyOrderTabSelections.completed));
                            }),
                        const SizedBox(width: AppDimensions.defaultPadding),
                      ],
                    ),
                    if (stateEnum == MyOrderStateEnum.loading) const CustomLoadingWidget(),
                    if (stateEnum == MyOrderStateEnum.error) const Center(child: Text("Something went wrong.")),
                    if (stateEnum == MyOrderStateEnum.loaded) ...[
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: itemCount,
                            itemBuilder: (_, index) {
                              final order = orders![index];
                              final List<OrderProductDetail> orderItems = order.items ?? [];
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: orderItems.length,
                                  itemBuilder: (_, index) {
                                    return OrderItemWidget(
                                        order: order,
                                        orderItem: orderItems[0],
                                        isComplete: state.selection == MyOrderTabSelections.completed,
                                        onTap: () => _navigateToOrderTrackingScreen(context, order, orderItems[index]));
                                  });
                            }),
                      )
                    ],
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _navigateToOrderTrackingScreen(BuildContext context, OrderModel order, OrderProductDetail orderItem) {
    Navigator.pushNamed(context, OrderTrackingScreen.routeName,
        // TODO: Replace orderItems
        arguments: OrderTrackingScreenArgs(order: order, orderItems: []));
  }

  void _navigateToQrScannerScreen() {
    Navigator.pushNamed(context, QrScannerScreen.routeName);
  }
}
