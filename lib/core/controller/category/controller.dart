import 'package:flutter_quiz_app/core/model/category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryList = <CategoryModel>[].obs;
  var selectedCategory = Rxn<CategoryModel>();
  var categoryIsLoading = false.obs;
}
