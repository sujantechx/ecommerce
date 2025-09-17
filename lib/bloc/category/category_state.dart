

import '../../model/category_model.dart'; // Adjust import path

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final List<CategoryModel> categories;
  CategorySuccessState({required this.categories});
}

class CategoryFailureState extends CategoryState {
  final String errorMsg;
  CategoryFailureState({required this.errorMsg});
}