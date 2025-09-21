

import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/repository/products_repository.dart';
import '../../model/products_model.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;

  ProductBloc({required this.productRepository})
      : super(ProductInitialState()) {
    // Correctly register the event handler for FetchProductsByCategoryEvent.
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);

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
    });}

    /// when a FetchProductsByCategoryEvent is added to the BLoC.
    void _onFetchProductsByCategory(
        FetchProductsByCategoryEvent event,
        Emitter<ProductState> emit,
        ) async {
      emit(ProductLoadingState());

      try {
        dynamic response = await productRepository.fetchProductsByCategory(event.categoryId);

        if (response != null && response["status"] == true) {
          ProductDataModel mData = ProductDataModel.fromJson(response);

          // 4. Emit success state with the list of products for the UI to display.
          emit(ProductSuccessState(products: mData.data ?? []));

        } else {
          // 5. Handle API-level errors (e.g., status: false).
          emit(ProductErrorState(errorMsg: response?["message"] ?? "An unknown error occurred"));
        }
      } catch (e) {
        // 6. Handle exceptions (e.g., network issues, parsing errors).
        emit(ProductErrorState(errorMsg: e.toString()));
      }
    }
  }
