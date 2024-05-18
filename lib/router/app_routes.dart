import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = const Scaffold(
        body: Center(
          child: Text(
            "404 NOT FOUND",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return CupertinoPageRoute(builder: (_) => widget, settings: settings);
  }
  
  // switch (settings.name) {
  //   case SplashScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SplashScreen(),
  //     );
  //   case OnboardingScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const OnboardingScreen(),
  //     );
  //   case SignInScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SignInScreen(),
  //     );
  //   case SignUpScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SignUpScreen(),
  //     );
  //   case SignUpSuccessScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SignUpSuccessScreen(),
  //     );
  //   case MainScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const MainScreen(),
  //       settings: const RouteSettings(name: MainScreen.routeName),
  //     );
  //   case PlaceOrderScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const PlaceOrderScreen(),
  //     );
  //   case PaymentScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const PaymentScreen(),
  //     );
  //   case AddAddressScreen.routeName:
  //     final args = settings.arguments as ShippingAddress?;
  //     return MaterialPageRoute(
  //       builder: (context) => AddAddressScreen(address: args),
  //     );
  //   case ChooseAddressScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const ChooseAddressScreen(),
  //     );
  //   case ChoosePromotionScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const ChoosePromotionScreen(),
  //     );
  //   case AddPaymentCardScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const AddPaymentCardScreen(),
  //     );
  //   case SetPasscodeScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SetPasscodeScreen(),
  //     );
  //   case CategoryScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const CategoryScreen(),
  //     );
  //   case CategoryProductScreen.routeName:
  //     final Category category = settings.arguments as Category;
  //     return MaterialPageRoute(
  //       builder: (context) => CategoryProductScreen(
  //         category: category,
  //       ),
  //     );
  //   case DetailProductScreen.routeName:
  //     final Product product = settings.arguments as Product;
  //     return MaterialPageRoute(
  //       builder: (context) => DetailProductScreen(
  //           // product: product,
  //           ),
  //       settings: settings,
  //     );
  //   case FilterScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const FilterScreen(),
  //     );
  //   case SearchScreen.routeName:
  //     final String query = settings.arguments as String;
  //     return MaterialPageRoute(
  //       builder: (context) => SearchScreen(
  //         query: query,
  //       ),
  //     );
  //   case ProductScreen.routeName:
  //     {
  //       final Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
  //       return MaterialPageRoute(
  //         builder: (context) => ProductScreen(
  //           sectionName: arg['sectionName'],
  //           products: arg['products'],
  //         ),
  //       );
  //     }
  //   case OrderProcessingScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const OrderProcessingScreen(),
  //     );
  //   case CartScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const CartScreen(),
  //     );
  //   case OrderTrackingScreen.routeName:
  //     final args = settings.arguments as OrderTrackingArguments;
  //     return MaterialPageRoute(
  //       builder: (context) => OrderTrackingScreen(
  //         order: args.order,
  //         orderItem: args.orderItem,
  //       ),
  //     );
  //   case MyOrderScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const MyOrderScreen(),
  //     );
  //   case ReviewScreen.routeName:
  //     final String productId = settings.arguments as String;
  //     return MaterialPageRoute(
  //       builder: (context) => ReviewScreen(
  //         productId: productId,
  //       ),
  //     );
  //   case PersonalDetailsScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const PersonalDetailsScreen(),
  //     );
  //   case ShippingAddressesScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const ShippingAddressesScreen(),
  //     );
  //   case SettingsScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SettingsScreen(),
  //     );
  //   case PromotionScreen.routeName:
  //     final List<Promotion> promotions = settings.arguments as List<Promotion>;
  //     return MaterialPageRoute(
  //       builder: (context) => PromotionScreen(
  //         promotions: promotions,
  //       ),
  //     );
  //   case SelectLanguageScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const SelectLanguageScreen(),
  //     );
  //   case FavoriteScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const FavoriteScreen(),
  //     );
  //   case FAQsScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const FAQsScreen(),
  //     );
  //   case MyCardsScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const MyCardsScreen(),
  //     );
  //   case EWalletScreen.routeName:
  //     return MaterialPageRoute(builder: (context) => const EWalletScreen(), settings: const RouteSettings(name: EWalletScreen.routeName));
  //   case TopUpScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const TopUpScreen(),
  //     );
  //   case EWalletCardsScreen.routeName:
  //     final args = settings.arguments as double;
  //     return MaterialPageRoute(
  //       builder: (context) => EWalletCardsScreen(amount: args),
  //     );
  //   case EWalletAddCardScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const EWalletAddCardScreen(),
  //     );
  //   case TransactionDetailsScreen.routeName:
  //     final args = settings.arguments as EWalletTransaction;
  //     return MaterialPageRoute(
  //       builder: (context) => TransactionDetailsScreen(transaction: args),
  //     );
  //   case AllTransactionHistoryScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const AllTransactionHistoryScreen(),
  //     );
  //   case ChatScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const ChatScreen(),
  //     );
  //   case RecordVoiceScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const RecordVoiceScreen(),
  //     );
  //   case QrScannerScreen.routeName:
  //     return MaterialPageRoute(
  //       builder: (context) => const QrScannerScreen(),
  //     );

  //   default:
  //     return MaterialPageRoute(
  //       builder: (context) => const Scaffold(
  //         body: Center(
  //           child: Text("No route"),
  //         ),
  //       ),
  //     );
  // }

   
}

class OrderTrackingArguments {
  final OrderModel order;
  final OrderProductDetail? orderItem;

  const OrderTrackingArguments({required this.order, this.orderItem});
}
