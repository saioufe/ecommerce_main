import 'dart:ffi';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/produc-colors-quantity-sizes.dart';
import 'package:ecommerce_template/models/product_images.dart';
import 'package:ecommerce_template/models/product_question.dart';
import 'package:ecommerce_template/models/slider.dart';
import 'package:ecommerce_template/widgets/size-product-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AllProviders extends ChangeNotifier {
  bool showNavBar = true;

  void NavBarShow(bool show) {
    showNavBar = show;
    notifyListeners();
  }

  static const String hostName = "http://10.0.2.2/ecommerceTemplate";

  static bool hasLogin;
  List<News> _posts = [];
  List<News> get posts {
    return _posts;
  }

  List data = [];
  List<dynamic> newsDataOffline;
  Future<void> fetchData() async {
    final response = await http.post('$hostName/get-posts-flutter.php');

//print(response.body);
    data = json.decode(response.body);
    final List<News> loadedPosts = [];
    if (data == null) {
      return;
    }
    newsDataOffline = data;
    data.forEach((newsId) {
      print(newsId["date"]);
      loadedPosts.add(News(
        id: newsId["id"],
        title: newsId["title"],
        text: newsId["text"],
        titleEnglish: newsId["titleEnglish"],
        textEnglish: newsId["textEnglish"],
        date: newsId["date"],
        image: newsId["image"],
      ));
    });
    _posts = loadedPosts;
    notifyListeners();
  }

  List<SliderModel> _slider = [];
  List<SliderModel> get sliders {
    return _slider;
  }

  List data4 = [];
  List<SliderModel> loadedSlider;
  List<dynamic> dataOfflineSlider;
  Future<void> fetchDataSliders() async {
    final response = await http.post('$hostName/get-sliders-flutter.php');

    data4 = json.decode(response.body);
    // print(response.body);
    final List<SliderModel> loadedSlider = [];
    if (data4 == null) {
      return;
    }
    dataOfflineSlider = data4;
    data4.forEach((newsId) {
      loadedSlider.add(SliderModel(
        image: newsId['image'],
        productid: newsId['url'],
      ));
    });
    _slider = loadedSlider;
    notifyListeners();
  }

  List<ProductShow> _allProducts = [];
  List<ProductShow> get allProducts {
    return _allProducts;
  }

  List dataAllProducts = [];
  List<ProductShow> loadedAllProducts;
  List<dynamic> dataOfflineAllProducts;
  double percentage;
  Future<void> fetchDataAllProducts() async {
    final response = await http.post('$hostName/get-all-products.php');

    dataAllProducts = json.decode(response.body);
    // print(response.body);
    final List<ProductShow> loadedAllProducts = [];
    if (dataAllProducts == null) {
      return;
    }
    dataOfflineAllProducts = dataAllProducts;
    dataAllProducts.forEach((newsId) {
      if (newsId['discount'] != "0") {
        double first =
            double.parse(newsId['discount']) - double.parse(newsId['price']);
        double second = first / double.parse(newsId['price']);
        percentage = second * 100;

        print(percentage);
      }
      loadedAllProducts.add(ProductShow(
        id: newsId['id'],
        image: newsId['image'],
        title: newsId['title'],
        titleEngilsh: newsId['titleEnglish'],
        description: newsId['description'],
        descriptionEnglish: newsId['descriptionEnglish'],
        favorite: newsId["favorite"] == "0" ? false : true,
        mainCategory: newsId['mainCategory'],
        subCategories: newsId['subCategories'].toString().split(","),
        price: newsId['price'],
        discount: newsId['discount'],
        discountPercentage: percentage,
        isQuestion: newsId['isQuestion'],
      ));
    });
    _allProducts = loadedAllProducts;
    notifyListeners();
  }

  static bool getOnceImage = false;

  List<ProductImage> allProductsImages;

  List dataAllProductImages = [];
  List<ProductImage> loadedAllProductsImages;
  List<dynamic> dataOfflineAllProductsImages;

  Future<void> fetchDataProductImages(String productId) async {
    final response = await http.post('$hostName/get-product-images.php', body: {
      'productId': productId,
    });

    dataAllProductImages = json.decode(response.body);
    final List<ProductImage> loadedAllProductsImages = [];
    if (dataAllProductImages == null) {
      return;
    }
    dataOfflineAllProductsImages = dataAllProductImages;
    dataAllProductImages.forEach((newsId) {
      loadedAllProductsImages.add(ProductImage(
        id: newsId['id'],
        product_id: newsId['product_id'],
        image: newsId['image'],
      ));
    });
    allProductsImages = loadedAllProductsImages;
    notifyListeners();
  }

  static bool getOnceQuestion = false;

  List<ProductQuestion> _questions = [];
  List<ProductQuestion> get questions {
    return _questions;
  }

  List dataAllProductQuestion = [];
  List<ProductQuestion> loadedAllProductsQuestions;
  static List<dynamic> dataOfflineAllProductsQuestion;

  Future<void> fetchDataProductQuestion(String productId) async {
    final response =
        await http.post('$hostName/get-product-questions.php', body: {
      'productId': productId,
    });

    dataAllProductQuestion = json.decode(response.body);
    final List<ProductQuestion> loadedAllProductsQuestions = [];
    if (dataAllProductQuestion == null) {
      return;
    }
    dataOfflineAllProductsQuestion = dataAllProductQuestion;
    dataAllProductQuestion.forEach((newsId) {
      loadedAllProductsQuestions.add(ProductQuestion(
        id: newsId['id'],
        product_id: newsId['product_id'],
        question: newsId['question'],
        answer: newsId['answer'],
      ));
    });
    _questions = loadedAllProductsQuestions;

    notifyListeners();
  }

  String getThePrice(ProductShow productCame) {
    if (selectedDiscount == '') {
      if (selectedPrice == '') {
        return productCame.price + " IQD";
      } else {
        return selectedPrice + " IQD";
      }
    } else {
      if (selectedDiscount != '') {
        return selectedDiscount + " IQD";
      }
    }
  }

  List<ProductColors> colorsForProduct = List<ProductColors>();
  List<String> sizesForSelectedColor = List<String>();
  List<Container> lastWidgets = List<Container>();
  String selectedProductId = '';
  Widget getSizes(String productId) {
    colorsForProduct = [];
    sizesForSelectedColor = [];
    lastWidgets = [];
    selectedPrice = '';
    selectedDiscount = '';

    selectedPercentage = 0.0;
    selectedProductId = productId;

    print(selectedProductId);
    colors.forEach((item) {
      if (item.product_id == productId) {
        colorsForProduct.add(item);
      }
    });

    colorsForProduct.forEach((item2) {
      final hexCode = item2.color.replaceAll('#', '');
      final color = Color(int.parse('FF$hexCode', radix: 16));

      if (selectedColor == color.toString()) {
        sizesForSelectedColor.add(item2.size);
      }
    });

    if (selectedColor == "" || selectedColor == null) {
      return Text("اختر احد الالوان");
    } else {
      sizesForSelectedColor.forEach((element) {
        lastWidgets.add(
          Container(
            padding: EdgeInsets.all(4),
            child: SizeProductBox(sizeText: element),
          ),
        );
      });
      return Column(
        children: lastWidgets.map((last) {
          return last;
        }).toList(),
      );
    }
  }

  static bool getOnceColors = false;
  static String selectedColor = '';
  // static bool isAnotherColorSelected = false;

  void isAnyColorSelected(String selectedColor2) {
    selectedColor = selectedColor2;

    notifyListeners();
  }

  static String selectedSize = '';
  // static bool isAnotherColorSelected = false;

  void isAnySizeSelected(String selectedSize2) {
    selectedSize = selectedSize2;

    notifyListeners();
  }

  String selectedPrice = '';
  String selectedDiscount = '';
  double selectedPercentage = 0.0;
  String selectedQuantity = '';
  static int selectedQuintity2 = 1;
  List<ProductColors> colorsForProduct2 = List<ProductColors>();

  void setPriceAndQuantity(String pressedSize) {
    colorsForProduct2 = [];
    selectedDiscount = '';
    colors.forEach((item) {
      if (item.product_id == selectedProductId) {
        colorsForProduct2.add(item);
      }
    });

    colorsForProduct2.forEach((element) {
      print('1');
      final hexCode = element.color.replaceAll('#', '');
      final color = Color(int.parse('FF$hexCode', radix: 16));
      if (color.toString() == selectedColor && element.size == pressedSize) {
        print('2');
        selectedPrice = element.price;
        selectedQuantity = element.quantity;
        if (element.discount != "0") {
          selectedDiscount = element.discount;
          double first =
              double.parse(element.discount) - double.parse(selectedPrice);
          double second = first / double.parse(selectedPrice);
          percentage = second * 100;
          selectedPercentage = percentage;
        }
      }
    });
    print("selected price : $selectedPrice");
    print("selected discount : $selectedDiscount");
    print("selected Percentage : $selectedPercentage");
    notifyListeners();
  }

  List<String> colorList = [];

  List<ProductColors> _colors = [];
  List<ProductColors> get colors {
    return _colors;
  }

  List dataAllProductColors = [];
  List<ProductColors> loadedAllProductsColors;
  static List<dynamic> dataOfflineAllProductsColors;

  Future<void> fetchDataProductColors(String productId) async {
    final response = await http.post('$hostName/get-product-colors.php', body: {
      'productId': productId,
    });

    dataAllProductColors = json.decode(response.body);
    final List<ProductColors> loadedAllProductsColors = [];
    if (dataAllProductColors == null) {
      return;
    }
    dataOfflineAllProductsColors = dataAllProductColors;
    colorList = [];
    dataAllProductColors.forEach((newsId) {
      if (!colorList.contains(newsId['color'])) {
        colorList.add(newsId['color']);
      }

      loadedAllProductsColors.add(ProductColors(
        id: newsId['id'],
        product_id: newsId['product_id'],
        color: newsId['color'],
        size: newsId['size'],
        quantity: newsId['quantity'],
        price: newsId['price'],
        discount: newsId['discount'],
      ));
    });

    _colors = loadedAllProductsColors;

    notifyListeners();
  }
}
