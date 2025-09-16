abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  int productId, qty;
  AddToCartEvent({required this.productId, required this.qty});
}

///fetchCart
class FetchCartEvent extends CartEvent{}