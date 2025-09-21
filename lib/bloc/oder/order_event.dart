abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final String userId;
  final List<int> productIds; // The list of products from the cart

  PlaceOrderEvent({required this.userId, required this.productIds});
}