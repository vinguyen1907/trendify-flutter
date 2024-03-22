import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/models/payment_method_resource.dart';

enum PaymentMethods {
  eWallet,
  mastercard,
  paypal,
  visa,
  googlePay,
  zaloPay,
  cashOnDelivery,
}

final Map<PaymentMethods, PaymentMethodResource> paymentMethodsResource = {
  PaymentMethods.eWallet: PaymentMethodResource(
    id: "0",
    name: "E-Wallet",
    imageAsset: AppAssets.imgEWallet,
    code: "e_wallet",
  ),
  PaymentMethods.mastercard: PaymentMethodResource(
    id: "1",
    name: "Credit Card",
    imageAsset: AppAssets.imgCreditCard,
    code: "mastercard",
  ),
  PaymentMethods.paypal: PaymentMethodResource(
    id: "2",
    name: "Paypal",
    imageAsset: AppAssets.imgPaypal,
    code: "paypal",
  ),
  PaymentMethods.visa: PaymentMethodResource(
    id: "3",
    name: "Visa",
    imageAsset: AppAssets.imgVisa,
    code: "visa",
  ),
  PaymentMethods.googlePay: PaymentMethodResource(
    id: "4",
    name: "Google Pay",
    imageAsset: AppAssets.imgGooglePay,
    code: "google_pay",
  ),
  PaymentMethods.zaloPay: PaymentMethodResource(
    id: "5",
    name: "ZaloPay",
    imageAsset: AppAssets.imgZaloPay,
    code: "zalo_pay",
  ),
  PaymentMethods.cashOnDelivery: PaymentMethodResource(
    id: "6",
    name: "Cash on delivery",
    imageAsset: AppAssets.imgCashOnDelivery,
    code: "cash_on_delivery",
  ),
};

// final paymentMethods = [
//   PaymentMethod(
//     id: "0",
//     name: "E-Wallet",
//     imageAsset: AppAssets.imgCreditCard,
//     code: "e_wallet",
//   ),
//   PaymentMethod(
//     id: "1",
//     name: "Credit Card",
//     imageAsset: AppAssets.imgCreditCard,
//     code: "mastercard",
//   ),
//   PaymentMethod(
//     id: "2",
//     name: "Paypal",
//     imageAsset: AppAssets.imgPaypal,
//     code: "paypal",
//   ),
//   PaymentMethod(
//     id: "3",
//     name: "Visa",
//     imageAsset: AppAssets.imgVisa,
//     code: "visa",
//   ),
//   PaymentMethod(
//     id: "4",
//     name: "Google Pay",
//     imageAsset: AppAssets.imgGooglePay,
//     code: "google_pay",
//   ),
//   PaymentMethod(
//     id: "5",
//     name: "Cash on delivery",
//     imageAsset: AppAssets.imgCashOnDelivery,
//     code: "cash_on_delivery",
//   ),
// ];
