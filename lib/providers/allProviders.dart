import 'dart:ffi';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/produc-colors-quantity-sizes.dart';
import 'package:ecommerce_template/models/product_images.dart';
import 'package:ecommerce_template/models/product_question.dart';
import 'package:ecommerce_template/models/slider.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/widgets/size-product-box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllProviders extends ChangeNotifier {
  bool showNavBar = true;

  void NavBarShow(bool show) {
    showNavBar = show;
    notifyListeners();
  }

  List<ProductShow> _allProductsCategory = [];
  List<ProductShow> get allProductsCategory {
    return _allProductsCategory;
  }

  List dataAllProductsCategory = [];
  List<ProductShow> loadedAllProductsCategory;
  static List<dynamic> dataOfflineAllProductsCategory;
  double percentage2;
  Future<void> fetchDataAllProductsOnCategory(
      String category, String sortType) async {
    print(sortType);
    final response =
        await http.post('$hostName/get-all-products-category.php', body: {
      'mainCategory': category,
      'sortType': sortType,
    });

    dataAllProductsCategory = json.decode(response.body);
    final List<ProductShow> loadedAllProductsCategory = [];
    if (dataAllProductsCategory == null) {
      return;
    }
    print(dataAllProductsCategory);
    dataOfflineAllProductsCategory = dataAllProductsCategory;
    dataAllProductsCategory.forEach((newsId) {
      if (newsId['discount'] != "0") {
        double first =
            double.parse(newsId['discount']) - double.parse(newsId['price']);
        double second = first / double.parse(newsId['price']);
        percentage2 = second * 100;
      }
      loadedAllProductsCategory.add(ProductShow(
        id: newsId['id'],
        image: newsId['image'],
        title: newsId['title'],
        titleEngilsh: newsId['titleEnglish'],
        description: newsId['description'],
        descriptionEnglish: newsId['descriptionEnglish'],
        //favorite: productFavoritesIds.contains(newsId['id']) ? true : false,
        mainCategory: newsId['mainCategory'],
        subCategories: newsId['subCategories'].toString().split(","),
        price: newsId['price'],
        discount: newsId['discount'],
        discountPercentage: percentage2,
        isQuestion: newsId['isQuestion'],
        date: newsId['date'],
        noColor: newsId['noColor'],
      ));
    });
    _allProductsCategory = loadedAllProductsCategory;

    notifyListeners();
  }

  List<ProductShow> _allProductsSimilar = [];
  List<ProductShow> get allProductsSimilar {
    return _allProductsSimilar;
  }

  List dataAllProductsSimilar = [];
  List<ProductShow> loadedAllProductsSimilar;
  static List<dynamic> dataOfflineAllProductsSimilar;
  double percentage3;
  Future<void> fetchDataAllProductsOnSimilar(
      String category, String subCategory) async {
    final response =
        await http.post('$hostName/get-similar-products.php', body: {
      'mainCategory': category,
      'subCategory': subCategory,
    });

    dataAllProductsSimilar = json.decode(response.body);
    final List<ProductShow> loadedAllProductsSimilar = [];
    if (dataAllProductsSimilar == null) {
      return;
    }
    //print(dataAllProductsSimilar);
    dataOfflineAllProductsSimilar = dataAllProductsSimilar;
    dataAllProductsSimilar.forEach((newsId) {
      if (newsId['discount'] != "0") {
        double first =
            double.parse(newsId['discount']) - double.parse(newsId['price']);
        double second = first / double.parse(newsId['price']);
        percentage3 = second * 100;
      }
      loadedAllProductsSimilar.add(ProductShow(
        id: newsId['id'],
        image: newsId['image'],
        title: newsId['title'],
        titleEngilsh: newsId['titleEnglish'],
        description: newsId['description'],
        descriptionEnglish: newsId['descriptionEnglish'],
        //favorite: productFavoritesIds.contains(newsId['id']) ? true : false,
        mainCategory: newsId['mainCategory'],
        subCategories: newsId['subCategories'].toString().split(","),
        price: newsId['price'],
        discount: newsId['discount'],
        discountPercentage: percentage3,
        isQuestion: newsId['isQuestion'],
        date: newsId['date'],
        noColor: newsId['noColor'],
      ));
    });
    _allProductsSimilar = loadedAllProductsSimilar;

    notifyListeners();
  }

  static const String hostName = "http://10.0.2.2/ecommerceTemplate";
  //static const String hostName = "http://app.creative-projects.co";

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
      loadedPosts.add(News(
        id: newsId["id"],
        title: newsId["title"],
        text: newsId["text"],
        titleEnglish: newsId["titleEnglish"],
        textEnglish: newsId["textEnglish"],
        date: newsId["date"],
        image: newsId["image"],
        showPosts: newsId["showPosts"],
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
    final List<SliderModel> loadedSlider = [];
    if (data4 == null) {
      return;
    }

    dataOfflineSlider = data4;
    data4.forEach((newsId) {
      loadedSlider.add(SliderModel(
        image: newsId['image'],
        productid: newsId['url'],
        hasProduct: newsId['hasProduct'] == "1" ? true : false,
      ));
    });
    _slider = loadedSlider;
    notifyListeners();
  }

  int numOfFavorite = 0;
  Map<String, bool> favoriteList = new Map<String, bool>();
  Future<void> fetchFavorites() async {
    numOfFavorite = 0;
    productFavoritesIds = [];
    final response =
        await http.post('$hostName/get-favorites-products.php', body: {
      'userId': UserProvider.userId.toString(),
    });

    dataAllProductFavorite = json.decode(response.body);

    dataAllProductFavorite.forEach((newsId) {
      productFavoritesIds.add(
        newsId['product_id'],
      );
    });

    allProducts.forEach((element) {
      if (productFavoritesIds.contains(element.id)) {
        favoriteList[element.id] = true;
        numOfFavorite += 1;
      } else {
        favoriteList[element.id] = false;
      }
    });
    notifyListeners();
    // favoriteList.forEach((key, value) {
    //   print("product id : $key      value : $value");
    // });
  }

  List<ProductShow> _allProducts = [];
  List<ProductShow> get allProducts {
    return _allProducts;
  }

  List dataAllProducts = [];
  List<ProductShow> loadedAllProducts;
  List<dynamic> dataOfflineAllProducts;
  double percentage;
  int theNumberOfShowsIntheMain;
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
      }
      loadedAllProducts.add(ProductShow(
        id: newsId['id'],
        image: newsId['image'],
        title: newsId['title'],
        titleEngilsh: newsId['titleEnglish'],
        description: newsId['description'],
        descriptionEnglish: newsId['descriptionEnglish'],
        //favorite: productFavoritesIds.contains(newsId['id']) ? true : false,
        mainCategory: newsId['mainCategory'],
        subCategories: newsId['subCategories'].toString().split(","),
        price: newsId['price'],
        discount: newsId['discount'],
        discountPercentage: percentage,
        isQuestion: newsId['isQuestion'],
        date: newsId['date'],
        noColor: newsId['noColor'],
      ));
    });

    if(loadedAllProducts.length > 2){
      theNumberOfShowsIntheMain = 2 ;
    }else {
      theNumberOfShowsIntheMain = 1;
    }
    fetchFavorites();
    _allProducts = loadedAllProducts;

    notifyListeners();
  }

  List<ProductShow> _allProductsOne = [];
  List<ProductShow> get allProductsOne {
    return _allProductsOne;
  }

  List dataAllProductsOne = [];
  List<ProductShow> loadedAllProductsOne;
  List<dynamic> dataOfflineAllProductsOne;
  double percentageOne;
  bool onceOneProduct = false;
  List<String> listOfSlidersId = [];
  Future<void> fetchDataOneProducts() async {
    if (onceOneProduct == false) {
      onceOneProduct = true;
      final response = await http.post('$hostName/get-one-product-slider.php');

      dataAllProductsOne = json.decode(response.body);
      // print(response.body);
      final List<ProductShow> loadedAllProductsOne = [];
      if (dataAllProductsOne == null) {
        return;
      }

      dataOfflineAllProductsOne = dataAllProductsOne;
      dataAllProductsOne.forEach((newsId) {
        listOfSlidersId.add(newsId['sliderId']);

        if (dataOfflineSlider != null) {
          if (newsId['discount'] != "0") {
            double first = double.parse(newsId['discount']) -
                double.parse(newsId['price']);
            double second = first / double.parse(newsId['price']);
            percentageOne = second * 100;
          }
          loadedAllProductsOne.add(
            ProductShow(
              id: newsId['id'],
              image: newsId['image'],
              title: newsId['title'],
              titleEngilsh: newsId['titleEnglish'],
              description: newsId['description'],
              descriptionEnglish: newsId['descriptionEnglish'],
              //favorite: productFavoritesIds.contains(newsId['id']) ? true : false,
              mainCategory: newsId['mainCategory'],
              subCategories: newsId['subCategories'].toString().split(","),
              price: newsId['price'],
              discount: newsId['discount'],
              discountPercentage: percentageOne,
              isQuestion: newsId['isQuestion'],
              date: newsId['date'],
              noColor: newsId['noColor'],
              sliderId: newsId['sliderId'],
            ),
          );
        }
      });

      fetchFavorites();
      _allProductsOne = loadedAllProductsOne;

      notifyListeners();
    }
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
    // selectedPrice = '';
    // selectedDiscount = '';

    //selectedPercentage = 0.0;
    selectedProductId = productId;

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
      return Text(Languages.selectedLanguage == 0
          ? "اختر احد الالوان"
          : "choose one color");
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

  static String selectedPrice = '';
  static String selectedDiscount = '';
  static double selectedPercentage = 0.0;
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
      final hexCode = element.color.replaceAll('#', '');
      final color = Color(int.parse('FF$hexCode', radix: 16));
      if (color.toString() == selectedColor && element.size == pressedSize) {
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

    notifyListeners();
  }

  static bool onceNoColor = false;
  List dataAllcolorsNoColors = [];
  Future<void> setPriceAndQuantityForNoColor(ProductShow productNoColor) async {
    if (onceNoColor == false) {
      onceNoColor = true;
      selectedDiscount = '';

      await http.post('$hostName/get-color-for-noColor.php', body: {
        'product_id': productNoColor.id,
      }).then((value) {
        //print(value.body);
        dataAllcolorsNoColors = json.decode(value.body);
        dataAllcolorsNoColors.forEach((newsId) {
          selectedPrice = newsId['price'];
          selectedQuantity = newsId['quantity'];
          selectedColor = "Color(0xffff0000)";
          selectedSize = '';
          if (newsId['discount'] != "0") {
            selectedDiscount = newsId['discount'];
            double first =
                double.parse(newsId['discount']) - double.parse(selectedPrice);
            double second = first / double.parse(selectedPrice);
            percentage = second * 100;
            selectedPercentage = percentage;
          }
        });
      });
      notifyListeners();
    }
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

  List dataAllProductFavorite = [];
  List<String> productFavoritesIds = [];
  String like;

  Future<void> setFavoriteProduct(ProductShow productShow, bool isLiked) async {
    if (UserProvider.userId != null) {
      productFavoritesIds = [];
      if (isLiked == true) {
        like = "true";
      } else {
        like = "false";
      }
      final response =
          await http.post('$hostName/set-favorite-product.php', body: {
        'userId': UserProvider.userId.toString(),
        'productId': productShow.id,
        'title': productShow.title,
        'titleEnglish': productShow.titleEngilsh,
        'description': productShow.description,
        'descriptionEnglish': productShow.descriptionEnglish,
        'mainCategory': productShow.mainCategory,
        'subCategories': productShow.subCategories[0],
        'image': productShow.image,
        'price': productShow.price,
        'discount': productShow.discount,
        'discountPercentage': productShow.discountPercentage.toString(),
        'isQuestion': productShow.isQuestion,
        'isLiked': like,
      });

      dataAllProductFavorite = json.decode(response.body);

      dataAllProductFavorite.forEach((newsId) {
        productFavoritesIds.add(
          newsId['product_id'],
        );
      });
      fetchFavorites();
    }

    // productFavoritesIds.forEach((value) {
    //   print(value);
    // });

    // print(dataAllProductFavorite);
  }
}
