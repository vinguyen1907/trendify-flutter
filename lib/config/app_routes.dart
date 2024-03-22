import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/all_transactions_history_screen/all_transactions_history_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_add_card_screen/e_wallet_add_card_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_cards_screen/e_wallet_cards_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/e_wallet_screen.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/add_payment_card_screen.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/chat_screen/chat_screen.dart';
import 'package:ecommerce_app/screens/choose_address_screen/choose_address_screen.dart';
import 'package:ecommerce_app/screens/choose_promotion_screen/choose_promotion_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_transaction_screen/e_wallet_transaction_screen.dart';
import 'package:ecommerce_app/screens/faqs_screen/faqs_screen.dart';
import 'package:ecommerce_app/screens/favorite_screen/favorite_screen.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/my_cards_screen/my_cards_screen.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/order_tracking_screen/order_tracking_screen.dart';
import 'package:ecommerce_app/screens/payment_screen/payment_screen.dart';
import 'package:ecommerce_app/screens/order_processing_screen/order_processing_screen.dart';
import 'package:ecommerce_app/screens/personal_details_screen/personal_details_screen.dart';
import 'package:ecommerce_app/screens/place_order_screen/place_order_screen.dart';
import 'package:ecommerce_app/screens/promotion_screen/promotion_screen.dart';
import 'package:ecommerce_app/screens/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:ecommerce_app/screens/record_voice_screen/record_voice_screen.dart';
import 'package:ecommerce_app/screens/review_screen/review_screen.dart';
import 'package:ecommerce_app/screens/select_language_screen/select_language_screen.dart';
import 'package:ecommerce_app/screens/set_passcode_screen/set_passcode_screen.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/category_product_screen/category_product_screen.dart';
import 'package:ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:ecommerce_app/screens/filter_screen/filter_screen.dart';
import 'package:ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:ecommerce_app/screens/search_screen/search_screen.dart';
import 'package:ecommerce_app/screens/settings_screen/settings_screen.dart';
import 'package:ecommerce_app/screens/shipping_addresses_screen/shipping_addresses_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_screen.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_success_screen.dart';
import 'package:ecommerce_app/screens/splash_screen/splash_screen.dart';
import 'package:ecommerce_app/screens/top_up_screen/top_up_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case SignUpSuccessScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpSuccessScreen(),
        );
      case MainScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
          settings: const RouteSettings(name: MainScreen.routeName),
        );
      case PlaceOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const PlaceOrderScreen(),
        );
      case PaymentScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const PaymentScreen(),
        );
      case AddAddressScreen.routeName:
        final args = settings.arguments as ShippingAddress?;
        return MaterialPageRoute(
          builder: (context) => AddAddressScreen(address: args),
        );
      case ChooseAddressScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChooseAddressScreen(),
        );
      case ChoosePromotionScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChoosePromotionScreen(),
        );
      case AddPaymentCardScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AddPaymentCardScreen(),
        );
      case SetPasscodeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SetPasscodeScreen(),
        );
      case CategoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      case CategoryProductScreen.routeName:
        final Category category = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (context) => CategoryProductScreen(
            category: category,
          ),
        );
      case DetailProductScreen.routeName:
        final Product product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (context) => DetailProductScreen(
            product: product,
          ),
        );
      case FilterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        );
      case SearchScreen.routeName:
        final String query = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => SearchScreen(
            query: query,
          ),
        );
      case ProductScreen.routeName:
        {
          final Map<String, dynamic> arg =
              settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ProductScreen(
              sectionName: arg['sectionName'],
              products: arg['products'],
            ),
          );
        }
      case OrderProcessingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrderProcessingScreen(),
        );
      case CartScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CartScreen(),
        );
      case OrderTrackingScreen.routeName:
        final args = settings.arguments as OrderTrackingArguments;
        return MaterialPageRoute(
          builder: (context) => OrderTrackingScreen(
            order: args.order,
            orderItem: args.orderItem,
          ),
        );
      case MyOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyOrderScreen(),
        );
      case ReviewScreen.routeName:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ReviewScreen(
            productId: productId,
          ),
        );
      case PersonalDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const PersonalDetailsScreen(),
        );
      case ShippingAddressesScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ShippingAddressesScreen(),
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );
      case PromotionScreen.routeName:
        final List<Promotion> promotions =
            settings.arguments as List<Promotion>;
        return MaterialPageRoute(
          builder: (context) => PromotionScreen(
            promotions: promotions,
          ),
        );
      case SelectLanguageScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SelectLanguageScreen(),
        );
      case FavoriteScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FavoriteScreen(),
        );
      case FAQsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FAQsScreen(),
        );
      case MyCardsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyCardsScreen(),
        );
      case EWalletScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const EWalletScreen(),
            settings: const RouteSettings(name: EWalletScreen.routeName));
      case TopUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const TopUpScreen(),
        );
      case EWalletCardsScreen.routeName:
        final args = settings.arguments as double;
        return MaterialPageRoute(
          builder: (context) => EWalletCardsScreen(amount: args),
        );
      case EWalletAddCardScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const EWalletAddCardScreen(),
        );
      case TransactionDetailsScreen.routeName:
        final args = settings.arguments as EWalletTransaction;
        return MaterialPageRoute(
          builder: (context) => TransactionDetailsScreen(transaction: args),
        );
      case AllTransactionHistoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AllTransactionHistoryScreen(),
        );
      case ChatScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );
      case RecordVoiceScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RecordVoiceScreen(),
        );
      case QrScannerScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const QrScannerScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No route"),
            ),
          ),
        );
    }
  }
}

class OrderTrackingArguments {
  final OrderModel order;
  final OrderProductDetail? orderItem;

  const OrderTrackingArguments({required this.order, this.orderItem});
}
