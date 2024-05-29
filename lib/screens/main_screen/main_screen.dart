import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/chat_screen/chat_screen.dart';
import 'package:ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/screens/main_screen/widgets/nav_bar.dart';
import 'package:ecommerce_app/screens/notification_screen/notification_screen.dart';
import 'package:ecommerce_app/screens/profile_screen/profile_screen.dart';
import 'package:ecommerce_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routeName = '/main-screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    GetIt.I.get(instanceName: HomeScreen.routeName),
    GetIt.I.get(instanceName: CartScreen.routeName),
    GetIt.I.get(instanceName: NotificationScreen.routeName),
    GetIt.I.get(instanceName: ProfileScreen.routeName),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      setState(() {
        currentIndex = 3;
      });
      Navigator.pushNamed(
        context,
        ChatScreen.routeName,
      );
    } else {
      setState(() {
        currentIndex = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, SplashScreen.routeName, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: NavBar(
          onTap: onTap,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
