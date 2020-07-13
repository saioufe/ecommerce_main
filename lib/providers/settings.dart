import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_template/models/Category.dart';
import 'package:flutter/material.dart';

import 'allProviders.dart';

class SettingsProvider extends ChangeNotifier {
  int selectedCat = 0;
  void setCat(int index) {
    selectedCat = index;
    notifyListeners();
  }

  List<Category> _categories = [];
  List<Category> get categories {
    return _categories;
  }

  List dataAllCategories = [];
  List<Category> loadedAllCategories;
  List<dynamic> dataOfflineAllCategories;
  bool once = false;
  Future<void> fetchDataCategories() async {
    if (once == false) {
      once = true;
      final response =
          await http.post('${AllProviders.hostName}/get-home-categories.php');

      dataAllCategories = json.decode(response.body);
      final List<Category> loadedAllCategories = [];
      if (dataAllCategories == null) {
        return;
      }
      dataOfflineAllCategories = dataAllCategories;
      dataAllCategories.forEach((newsId) {
        loadedAllCategories.add(Category(
          id: newsId['id'],
          image: newsId['image'],
          mainCategory: newsId['mainCategory'],
          mainCategoryEnglish: newsId['mainCategoryEnglish'],
          subCategories: newsId['subCategories'].toString().split(","),
          subCategoriesEnglish:
              newsId['subCategoriesEnglish'].toString().split(","),
          showCategories: newsId['showCategories'],
          homeCategoriesStyle: newsId['homeCategoriesStyle'],
        ));
      });
      _categories = loadedAllCategories;

      notifyListeners();
    }
  }
}
