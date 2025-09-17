abstract class ProductEvent {}

class GetProductsEvent extends ProductEvent{
  int ? catId;
  GetProductsEvent({required this.catId});
}


// This event will be dispatched with the category ID to fetch products
class FetchProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  FetchProductsByCategoryEvent({required this.categoryId});
}