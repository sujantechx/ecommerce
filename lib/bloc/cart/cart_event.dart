import '../../model/cart_model.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  int productId, qty;
  AddToCartEvent({required this.productId, required this.qty});
}

///fetchCart
class FetchCartEvent extends CartEvent{}

class UpdateCartQuantityEvent extends CartEvent {
  final CartModel item;
  final String action; // "increment" or "decrement"

  UpdateCartQuantityEvent({required this.item, required this.action});
}