import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/remote/repository/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryInitialState()) {
    on<FetchCategoriesEvent>((event, emit) async {
      // Emit Loading state to show a spinner in the UI
      emit(CategoryLoadingState());
      try {
        // Fetch data from the repository
        final categories = await categoryRepository.getAllCategories();
        // Emit Success state with the fetched data
        emit(CategorySuccessState(categories: categories));
      } catch (e) {
        // Emit Failure state if an error occurs
        emit(CategoryFailureState(errorMsg: e.toString()));
      }
    });
  }
}