

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
