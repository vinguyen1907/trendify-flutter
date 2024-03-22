import 'package:flutter/material.dart';

class MyInkWellIconButton extends StatelessWidget {
  const MyInkWellIconButton(
      {super.key,
      required this.radius,
      this.onTap,
      required this.icon,
      required this.color});
  final double radius;
  final VoidCallback? onTap;
  final Widget icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: color),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
