import 'package:flutter/material.dart';

class ProductClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(20, 0);
    path.lineTo(size.width - 20, 0);

    path.quadraticBezierTo(size.width, 0, size.width, 20);

    path.lineTo(size.width, size.height * 4 / 5 - 20);

    path.quadraticBezierTo(
        size.width, size.height * 4 / 5, size.width - 20, size.height * 4 / 5);

    path.lineTo(size.width - size.height * 3 / 10 + 20, size.height * 4 / 5);

    path.quadraticBezierTo(
        size.width - size.height * 3 / 10,
        size.height * 4 / 5,
        size.width - size.height * 3 / 10,
        size.height * 4 / 5 + 20);

    path.lineTo(size.width - size.height * 3 / 10, size.height - 20);

    path.quadraticBezierTo(size.width - size.height * 3 / 10, size.height,
        size.width - size.height * 3 / 10 - 20, size.height);
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.lineTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
