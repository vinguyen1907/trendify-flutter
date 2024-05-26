import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'package:ecommerce_app/router/app_routes.dart';
import 'package:ecommerce_app/constants/app_themes.dart';
import 'package:ecommerce_app/dependencies/app_dependencies.dart';
import 'package:ecommerce_app/screens/splash_screen/splash_screen.dart';
import 'package:ecommerce_app/services/local_notification_service.dart';

import 'blocs/blocs.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final navigatorKey = GlobalKey<NavigatorState>();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  await setUpNotification();

  await AppDependencies.init();

  HttpOverrides.global = MyHttpOverrides();
 
  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
}

Future<void> setUpNotification() async {
  await LocalNotificationService.initialize();
  FirebaseMessaging.onMessage.listen(LocalNotificationService.handleMessage);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('all');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()..add(const LoadTheme())),
        BlocProvider(create: (_) => AuthBloc()..add(CheckAuthentication())),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => ShowNotificationBloc()),
        BlocProvider(create: (_) => PlaceOrderBloc()),
        BlocProvider(create: (_) => PaymentMethodsBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => SearchFilterBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => CategoryProductBloc()),
        BlocProvider(
            create: (context) => ProductBloc(
                showNotificationBloc:
                    BlocProvider.of<ShowNotificationBloc>(context))),
        BlocProvider(create: (_) => ProductScreenBloc()),
        BlocProvider(create: (_) => SimilarProductsBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => OrderProcessingBloc()),
        BlocProvider(create: (_) => AddressesBloc()),
        BlocProvider(create: (_) => ReviewScreenBloc()),
        BlocProvider(create: (_) => ChatBloc()),
        BlocProvider(create: (_) => LanguageBloc()..add(const LoadLanguage())),
        BlocProvider(create: (_) => EWalletCardsBloc()),
        BlocProvider(create: (_) => EWalletTransactionsBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          Locale? locate;
          if (state is LanguageLoaded) {
            locate = Locale(state.locale);
          }
          return MaterialApp(
            title: 'Trendify',
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter().onGenerateRoute,
            theme: AppThemes().lightTheme,
            darkTheme: AppThemes().darkTheme,
            themeMode: context.watch<ThemeBloc>().state.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate, // Generated delegate
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale: locate,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
