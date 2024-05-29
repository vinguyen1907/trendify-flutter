class ApiConstants {
  static const String baseUrl = "http://192.168.0.8:8888/api/v1";
  static const String webSocketUrl = "wss://192.168.0.8:8082/ws";

  static const String registerUrl = "$baseUrl/auth/register";
  static const String loginUrl = "$baseUrl/auth/authenticate";
  static const String usersUrl = "$baseUrl/users";
  static const String productsUrl = "$baseUrl/products";
  static const String cartUrl = "$baseUrl/cart";
  static const String shippingAddressUrl = "$baseUrl/shipping-address";
  static const String orderUrl = "$baseUrl/order";

  // User apis
  static const String recordUserClickUrl = "$baseUrl/history/click";
  static const String userGetRecommendedProductsUrl = "$usersUrl/user/recommend";

  // Product apis
  static const String fetchProductSpecs = "$productsUrl/{productId}/specs";
  static const String fetchSimilarProducts = "$productsUrl/{productCode}/related";

  // Payment apis
  static const String paymentBaseUrl = "$baseUrl/payment";
  static const String paymentInfosUrl = "$paymentBaseUrl/infos";
}
