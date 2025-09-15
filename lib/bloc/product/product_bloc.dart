

import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/repository/products_repository.dart';
import '../../model/products_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;

  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {

    on<GetProductsEvent>((event, emit) async{
      emit(ProductLoadingState());

      try {

        dynamic res = await productRepository.getProducts(event.catId);

        if(res["status"]){
          ProductDataModel mData = ProductDataModel.fromJson(res);
          emit(ProductLoadedState(mProducts: mData.data ?? []));
        } else {
          emit(ProductErrorState(errorMsg: res["message"]));
        }


      } catch (e) {
        emit(ProductErrorState(errorMsg: e.toString()));
      }
    });
  }
}