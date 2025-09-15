import 'package:ecommerce/model/products_model.dart';

abstract class  ProductState{}

class ProductInitialState extends ProductState{}
class ProductLoadingState extends ProductState{}
class ProductLoadedState extends ProductState{
  List<ProductModel> mProducts;
  ProductLoadedState({required this.mProducts});
}
class ProductSuccessState extends ProductState{}
class ProductFailureState extends ProductState{
  String errorMsg;
  ProductFailureState({required this.errorMsg});
}