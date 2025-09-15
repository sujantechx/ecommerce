
import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:ecommerce/data/remote/repository/products_repository.dart';
import 'package:ecommerce/model/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  ProductRepository productRepository;
  ProductBloc({required this.productRepository}):super(ProductInitialState()){
    on<GetProductsEvent>((event,emit)async{
      emit(ProductInitialState());
      try{
        dynamic res=await productRepository.getProducts(event.catId);

        if(res['status']){
          ProductDataModel mData=ProductDataModel.fromJson(res);
          emit(ProductFailureState(errorMsg: res['message']));
        }
      }catch(e){
        emit(ProductFailureState(errorMsg: e.toString()));
      }
    });
  }
}