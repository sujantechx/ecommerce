

import '../../model/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}
class CartLoadingState extends CartState {}
class CartSuccessState extends CartState {
  List<CartModel>? cartList;
  CartSuccessState({this.cartList});
}
class CartFailureState extends CartState {
  String errorMsg;
  CartFailureState({required this.errorMsg});
}