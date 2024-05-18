import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../screens/screens.dart';

class PageDependencies {
  static Future<void> setUp(GetIt injector) async {
    injector.registerFactory<Widget>(() => const SplashScreen(),
        instanceName: SplashScreen.routeName);
    injector.registerFactory<Widget>(() => const OnboardingScreen(),
        instanceName: OnboardingScreen.routeName);
    injector.registerFactory<Widget>(() => const SignInScreen(),
        instanceName: SignInScreen.routeName);
    injector.registerFactory<Widget>(() => const SignUpScreen(),
        instanceName: SignUpScreen.routeName);
    injector.registerFactory<Widget>(() => const SignUpSuccessScreen(),
        instanceName: SignUpSuccessScreen.routeName);
    injector.registerFactory<Widget>(() => const MainScreen(),
        instanceName: MainScreen.routeName);
    injector.registerFactory<Widget>(() => const PlaceOrderScreen(),
        instanceName: PlaceOrderScreen.routeName);
    injector.registerFactory<Widget>(() => const PaymentScreen(),
        instanceName: PaymentScreen.routeName);
    injector.registerFactory<Widget>(() => const AddAddressScreen(),
        instanceName: AddAddressScreen.routeName);
    injector.registerFactory<Widget>(() => const ChooseAddressScreen(),
        instanceName: ChooseAddressScreen.routeName);
    injector.registerFactory<Widget>(() => const ChoosePromotionScreen(),
        instanceName: ChoosePromotionScreen.routeName);
    injector.registerFactory<Widget>(() => const AddPaymentCardScreen(),
        instanceName: AddPaymentCardScreen.routeName);
    injector.registerFactory<Widget>(() => const SetPasscodeScreen(),
        instanceName: SetPasscodeScreen.routeName);
    injector.registerFactory<Widget>(() => const CategoryScreen(),
        instanceName: CategoryScreen.routeName);
    injector.registerFactory<Widget>(() => const CategoryProductScreen(),
        instanceName: CategoryProductScreen.routeName);
    injector.registerFactory<Widget>(() => const DetailProductScreen(),
        instanceName: DetailProductScreen.routeName);
    injector.registerFactory<Widget>(() => const FilterScreen(),
        instanceName: FilterScreen.routeName);
    injector.registerFactory<Widget>(() => const SearchScreen(),
        instanceName: SearchScreen.routeName);
    injector.registerFactory<Widget>(() => const AllProductsScreen(),
        instanceName: AllProductsScreen.routeName);
    injector.registerFactory<Widget>(() => const OrderProcessingScreen(),
        instanceName: OrderProcessingScreen.routeName);
    injector.registerFactory<Widget>(() => const CartScreen(),
        instanceName: CartScreen.routeName);
    injector.registerFactory<Widget>(() => const OrderTrackingScreen(),
        instanceName: OrderTrackingScreen.routeName);
    injector.registerFactory<Widget>(() => const MyOrderScreen(),
        instanceName: MyOrderScreen.routeName);
    injector.registerFactory<Widget>(() => const ReviewScreen(),
        instanceName: ReviewScreen.routeName);
    injector.registerFactory<Widget>(() => const PersonalDetailsScreen(),
        instanceName: PersonalDetailsScreen.routeName);
    injector.registerFactory<Widget>(() => const ShippingAddressesScreen(),
        instanceName: ShippingAddressesScreen.routeName);
    injector.registerFactory<Widget>(() => const SettingsScreen(),
        instanceName: SettingsScreen.routeName);
    injector.registerFactory<Widget>(() => const PromotionScreen(),
        instanceName: PromotionScreen.routeName);
    injector.registerFactory<Widget>(() => const SelectLanguageScreen(),
        instanceName: SelectLanguageScreen.routeName);
    injector.registerFactory<Widget>(() => const FavoriteScreen(),
        instanceName: FavoriteScreen.routeName);
    injector.registerFactory<Widget>(() => const FAQsScreen(),
        instanceName: FAQsScreen.routeName);
    injector.registerFactory<Widget>(() => const MyCardsScreen(),
        instanceName: MyCardsScreen.routeName);
    injector.registerFactory<Widget>(() => const EWalletScreen(),
        instanceName: EWalletScreen.routeName);
    injector.registerFactory<Widget>(() => const TopUpScreen(),
        instanceName: TopUpScreen.routeName);
    injector.registerFactory<Widget>(() => const EWalletCardsScreen(),
        instanceName: EWalletCardsScreen.routeName);
    injector.registerFactory<Widget>(() => const EWalletAddCardScreen(),
        instanceName: EWalletAddCardScreen.routeName);
    injector.registerFactory<Widget>(() => const TransactionDetailsScreen(),
        instanceName: TransactionDetailsScreen.routeName);
    injector.registerFactory<Widget>(() => const AllTransactionHistoryScreen(),
        instanceName: AllTransactionHistoryScreen.routeName);
    injector.registerFactory<Widget>(() => const ChatScreen(),
        instanceName: ChatScreen.routeName);
    injector.registerFactory<Widget>(() => const RecordVoiceScreen(),
        instanceName: RecordVoiceScreen.routeName);
    injector.registerFactory<Widget>(() => const QrScannerScreen(),
        instanceName: QrScannerScreen.routeName);
  }
}
