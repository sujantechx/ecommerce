

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/repository/cart_repo.dart';
import '../../model/cart_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async{
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.addToCart(productId: event.productId, qty: event.qty);

        if(res["status"] == "true" || res["status"]){
          emit(CartSuccessState());
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }

      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<UpdateCartQuantityEvent>((event, emit) async {
      try {
        await cartRepository.updateCartQuantity(
          // Make sure your CartModel has a unique ID for the cart entry
          cartItemId: event.item.id.toString(),
          action: event.action,
        );
        // On success, re-fetch the entire cart to ensure data is in sync
        add(FetchCartEvent());
      } catch (e) {
        // You can emit a specific error state here if needed,
        // but re-fetching will handle showing the user the last valid state.
      }
    });

    on<FetchCartEvent>((event, emit) async{

      emit(CartLoadingState());

      try{
        dynamic res = await cartRepository.fetchCart();

        if(res["status"] == "true" || res["status"]){
          emit(CartSuccessState(cartList: CartDataModel.fromJson(res).data));
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }

      } catch (e){
        emit(CartFailureState(errorMsg: e.toString()));
      }

    });
  }
}
