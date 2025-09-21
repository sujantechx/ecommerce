


import '../../../domain/constants/app_urls.dart';
import '../../../model/category_model.dart';
import '../helper/api_helper.dart';

class CategoryRepository {
  final ApiHelper apiHelper;

  CategoryRepository({required this.apiHelper});

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await apiHelper.getAPI(url: AppUrls.getCategoryUrl);

      // Check if the 'data' key exists and is a list
      if (response != null && response['data'] is List) {
        // Cast the list of dynamic objects
        List<dynamic> categoryData = response['data'];

        // Map each item in the list to a CategoryModel
        return categoryData.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to parse category data.");
      }
    } catch (e) {
      // Re-throw the exception to be caught by the BLoC
      rethrow;
    }
  }
}