abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent{
  int ? catId;
  GetProductsEvent({required this.catId});
}
