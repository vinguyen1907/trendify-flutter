import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  final EWalletTransaction transaction;

  const TransactionItemWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subtitle = "";
    String amount = "";
    String type = "";
    String? imageUrl;

    if (transaction is TopUpTransaction) {
      title = "Top Up Wallet";
      subtitle = transaction.createdTime.toTransactionDateTimeFormat();
      amount = (transaction as TopUpTransaction).amount.toPriceString();
      type = "Top Up";
    } else if (transaction is PaymentTransaction) {
      final temp = transaction as PaymentTransaction;
      title = temp.items.length == 1
          ? temp.items.first.product.name
          : "Order Payment";
      subtitle = transaction.createdTime.toTransactionDateTimeFormat();
      amount = temp.totalAmount.toPriceString();
      type = "Orders";
      imageUrl = temp.items.first.product.imgUrl;
    }

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(title, style: Theme.of(context).textTheme.labelLarge),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: AppDimensions.circleCorners,
            image: transaction is PaymentTransaction
                ? DecorationImage(
                    image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                : null,
          ),
          alignment: Alignment.center,
          child: transaction is TopUpTransaction
              ? const MyIcon(icon: AppAssets.icWallet)
              : null,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(amount, style: AppStyles.labelMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(type, style: AppStyles.bodyLarge),
                const SizedBox(width: 5),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: transaction is TopUpTransaction
                          ? Colors.blue
                          : Colors.red,
                      borderRadius: BorderRadius.circular(3)),
                  alignment: Alignment.center,
                  child: MyIcon(
                    icon: transaction is TopUpTransaction
                        ? AppAssets.icArrowUp
                        : AppAssets.icArrowDown,
                    height: 12,
                    colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
