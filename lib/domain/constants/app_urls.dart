class AppUrls{
  static const String baseUrl = "https://ecommerceapi.projectnest.online/ecommerce-api/";

  static const String loginUrl = "${baseUrl}user/login";
  static const String userProfileUrl = "${baseUrl}user/profile";
  static const String registerUrl = "${baseUrl}user/registration";

  static const String getProductsUrl = "${baseUrl}products";
  static const String getCategoryUrl = "${baseUrl}categories";
  static const String addToCartUrl = "${baseUrl}add-to-cart";
  static const String fetchCartUrl = "${baseUrl}product/view-cart";
  static const String updateCartQuantityUrl  = "${baseUrl}product/decrement-quantity";
  static const String deleteCartUrl = "${baseUrl}product/delete-cart";
  static const String createOrderUrl = "${baseUrl}product/create-order";
  static const String getOrderUrl = "${baseUrl}product/get-order";
}