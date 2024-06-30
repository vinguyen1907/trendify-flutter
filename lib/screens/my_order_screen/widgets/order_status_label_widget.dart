import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

class OrderStatusLabel extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String labelText = status.toOrderStatusLabel();

    switch (status) {
      case OrderStatus.processing:
      case OrderStatus.pending:
      case OrderStatus.onHold:
      case OrderStatus.outForDelivery:
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue;
        break;
      case OrderStatus.delivered:
      case OrderStatus.shipped:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green;
        break;
      case OrderStatus.cancelled:
      case OrderStatus.returned:
      case OrderStatus.refunded:
      case OrderStatus.failedDelivery:
        backgroundColor = Colors.pink[100]!;
        textColor = Colors.pink;
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey;
        labelText = 'Not found';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: textColor),
      ),
    );
  }
}
