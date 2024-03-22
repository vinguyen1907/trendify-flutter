import 'package:ecommerce_app/screens/main_screen/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.onTap, required this.currentIndex});
  final Function onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              spreadRadius: 3,
              blurRadius: 7,
              color: Colors.grey.withOpacity(0.4))
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavBarItem(
            iconName: "home",
            label: "Home",
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          NavBarItem(
            iconName: "cart",
            label: "Cart",
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          NavBarItem(
            iconName: "notification",
            label: "Notification",
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          NavBarItem(
            iconName: "profile",
            label: "Profile",
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
