import 'dart:convert';

import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/address.dart';
import 'package:ecommerce_template/models/cartItemModel.dart';
import 'package:ecommerce_template/models/city.dart';
import 'package:ecommerce_template/models/country.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'allProviders.dart';

class CartProvider with ChangeNotifier {
  AllProviders _allProviders;
  CartProvider(this._allProviders);
  static String mainTitle = 'سلة المشتريات';
  double lastTotalPrice = 0.0;
  double lastlastTotalPrice = 0.0;
  bool isBuyed = false;
  BuildContext contextDone;

  double getTotalPrice(double promocode) {
    if (promocode != 0.0 && promocode < lastTotalPrice) {
      lastlastTotalPrice =
          (lastTotalPrice + double.parse(selectedShipPrice)) - promocode;
      return lastlastTotalPrice;
    } else {
      lastlastTotalPrice = lastTotalPrice + double.parse(selectedShipPrice);
      return lastlastTotalPrice;
    }
  }

  Future<String> addItemToCart(
    ProductShow product,
    String productPrice,
    String productDiscount,
    String productSize,
    String productColor,
    int productQuantity,
  ) async {
    double price;

    print("this price : $productPrice");
    print("this discount : $productDiscount");

    if (productDiscount != null) {
      price = double.parse(productDiscount) * productQuantity;
    } else {
      price = double.parse(productPrice) * productQuantity;
    }

    // if (price < 1000) {
    //   print(price.toInt().toString());
    // } else {
    //   print(price.toStringAsFixed(3));
    // }

    final response =
        await http.post("${AllProviders.hostName}/insert-cart-item.php", body: {
      "productId": product.id,
      "userId": UserProvider.userId.toString(),
      "productPrice":
          price > 1000 ? price.toStringAsFixed(3) : price.toString(),
      "productSize": productSize,
      "productColor": productColor,
      "productQuantity": productQuantity.toString(),
    });

    return response.body;
  }

  List<CartItemModel> _cartItems = [];
  List<CartItemModel> get colors {
    return _cartItems;
  }

  List dataAllCartItems = [];
  List<CartItemModel> loadedAllCartItems;
  int numOfCartItems = 0;
  Color otherColor;
  Map<String, bool> favoriteList = new Map<String, bool>();
  Future<void> getCartItems() async {
    loadedAllCartItems = [];
    numOfCartItems = 0;
    lastTotalPrice = 0.0;
    final response = await http
        .post('${AllProviders.hostName}/get-cart-items-flutter.php', body: {
      'userId': UserProvider.userId.toString(),
    });

    dataAllCartItems = json.decode(response.body);

    // print(dataAllCartItems);

    dataAllCartItems.forEach((newsId) {
      lastTotalPrice += double.parse(newsId['productPrice']);
      numOfCartItems += 1;
      ProductShow theProduct;
      _allProviders.allProducts.forEach((element) {
        if (newsId['product_id'] == element.id) {
          String valueString = newsId['productColor']
              .split('(0x')[1]
              .split(')')[0]; // kind of hacky..
          int value = int.parse(valueString, radix: 16);
          otherColor = new Color(value);
          theProduct = element;
        }
      });

      loadedAllCartItems.add(CartItemModel(
        id: newsId['id'],
        product_id: newsId['product_id'],
        product: theProduct,
        productColor: otherColor,
        productPrice: newsId['productPrice'],
        productSize: newsId['productSize'],
        productQuantity: newsId['productQuantity'],
      ));
    });
    _cartItems = loadedAllCartItems;
    //notifyListeners();
  }

  int cartItemNumber;
  bool onceFavorite = false;
  Future<int> getNumCartItem() async {
    if (onceFavorite == false) {
      onceFavorite = true;
      await http.post('${AllProviders.hostName}/get-num-cart-items-flutter.php',
          body: {
            'userId': UserProvider.userId.toString(),
          }).then((value) {
        cartItemNumber = int.parse(value.body);
        return cartItemNumber;
      });
      notifyListeners();
      return cartItemNumber;
    }
  }

  Future<void> deleteCartItems(
      String productId, String productColor, String productSize) async {
    await http
        .post('${AllProviders.hostName}/delete-cart-item-flutter.php', body: {
      'userId': UserProvider.userId.toString(),
      'product_id': productId,
      'productColor': productColor,
      'productSize': productSize,
    }).then((value) {
      decressCartItemsBadgeNumber();
      getCartItems().then((value) {
        notifyListeners();
      });
    });
    notifyListeners();
  }

  String promocodeValue = "0";
  Future<void> getPromocodes(
    String name,
  ) async {
    await http
        .post('${AllProviders.hostName}/get-promocode-flutter.php', body: {
      'name': name,
    }).then((value) {
      if (value.body == '0') {
        promocodeValue = "0";
      } else {
        promocodeValue = value.body;
      }
    });
    notifyListeners();
  }

  List countries = [];
  List<Country> loadedCountries;
  bool once = false;

  List<Country> _allcountries = [];
  List<Country> get allcountries {
    return _allcountries;
  }

  Future<void> getCountries() async {
    if (once == false) {
      List<Country> loadedCountries = [];
      final response =
          await http.post('${AllProviders.hostName}/get-countries-flutter.php');

      countries = json.decode(response.body);

      print(countries);
      countries.forEach((newsId) {
        loadedCountries.add(Country(
          id: newsId['id'],
          nameArabic: newsId['nameArabic'],
          nameEnglish: newsId['nameEnglish'],
        ));
      });
      once = true;
      _allcountries = loadedCountries;
      notifyListeners();
    }
  }

  List cities = [];
  List<City> loadedCities;
  bool once2 = false;

  List<City> _allcities = [];
  List<City> get allcities {
    return _allcities;
  }

  Future<void> getCities(String countryName) async {
    if (once2 == false) {
      List<City> loadedCities = [];
      final response = await http
          .post('${AllProviders.hostName}/get-cities-flutter.php', body: {
        'countryName': countryName,
      });

      cities = json.decode(response.body);

      print(cities);
      cities.forEach((newsId) {
        loadedCities.add(City(
          id: newsId['id'],
          nameArabic: newsId['nameArabic'],
          nameEnglish: newsId['nameEnglish'],
          cost: newsId['cost'],
          country_id: newsId['country_id'],
        ));
      });
      once2 = true;
      _allcities = loadedCities;
      notifyListeners();
    }
  }

  List address = [];
  static List<Address> loadedaddress;
  static List<dynamic> dataOfflineAllAddress;
  bool noAddress = true;
  static bool once3 = false;
  List<Address> _alladdress = [];
  List<Address> get alladdress {
    return _alladdress;
  }

  Future<void> getAddress() async {
    if (once3 == false) {
      loadedaddress = [];
      final response = await http
          .post('${AllProviders.hostName}/get-address-flutter.php', body: {
        'userId': UserProvider.userId.toString(),
      });

      if (response.body == '0') {
        print("no addrtess");
        noAddress = true;
        return;
      } else {
        noAddress = false;
      }

      address = json.decode(response.body);
      print(address);

      if (address == null) {
        return;
      }

      dataOfflineAllAddress = address;

      address.forEach((newsId) {
        loadedaddress.add(Address(
          id: newsId['id'],
          name: newsId['name'],
          phone: newsId['phone'],
          address: newsId['addres'],
          country: newsId['country'],
          city: newsId['city'],
        ));
      });
      _alladdress = loadedaddress;

      notifyListeners();
    }
    once3 = true;
  }

  Future<String> insertAddress(
    String name,
    String phone,
    String address,
    String country,
    String city,
  ) async {
    final response = await http
        .post('${AllProviders.hostName}/insert-address-flutter.php', body: {
      'userId': UserProvider.userId.toString(),
      'name': name,
      'phone': phone,
      'address': address,
      'country': country,
      'city': city,
    });
    print(response.body);

    notifyListeners();
    return response.body;
  }

  Future<void> deleteAddress(String addressId) async {
    await http
        .post('${AllProviders.hostName}/delete-address-flutter.php', body: {
      'userId': UserProvider.userId.toString(),
      'addressId': addressId,
    }).then((value) {
      getAddress();
      notifyListeners();
    });
  }

  Address selectedAddress;
  String selectedShipPrice;

  void getChoosenAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("address")) {
      alladdress.forEach((element) {
        if (element.id == prefs.getString("address")) {
          selectedAddress = element;
          getCities(selectedAddress.country).then((value) {
            allcities.forEach((element2) {
              if (element2.nameArabic == selectedAddress.city) {
                selectedShipPrice = element2.cost;
              }
            });
          });
        }
      });
    } else {
      selectedAddress = null;
    }
    notifyListeners();
  }

  String productNames = '';
  String colorsNames = '';
  String quantities = '';
  String sizes = '';
  bool onceOrder = false;
  int index = 0;
  Future<String> sendOrder(String promocode) async {
    loadedAllCartItems.forEach((element2) {
      productNames += element2.product.title + ',';
      quantities += element2.productQuantity + ',';
      _allProviders.fetchDataProductColors(element2.product_id).then((value) {
        _allProviders.colors.forEach((element) async {
          // loadedAllCartItems.forEach((element2) {
          final hexCode = element.color.replaceAll('#', '');
          final color = Color(int.parse('FF$hexCode', radix: 16));

          if (element.size == element2.productSize &&
              color == element2.productColor) {
            index++;
            colorsNames += element.color + ',';
            sizes += element.size + ',';
            print(sizes);
            if (index == loadedAllCartItems.length) {
              final respo = await http.post(
                  '${AllProviders.hostName}/send-order-flutter.php',
                  body: {
                    'userId': UserProvider.userId.toString(),
                    'product_ids': productNames,
                    'colors': colorsNames,
                    'size': sizes,
                    'quantities': quantities,
                    'phone': selectedAddress.phone,
                    'address': selectedAddress.address +
                        ' ' +
                        selectedAddress.country +
                        ' ' +
                        selectedAddress.city,
                    'promocode': promocode,
                    'price': lastlastTotalPrice.toStringAsFixed(3),
                    'name': selectedAddress.name,
                  }).then((value) {
                if (value.body == 'done') {
                  isBuyed = true;
                }
                return value.body;
              });
            }
          }
          //});
        });
      });
    });
  }

  void incressCartItemsBadgeNumber() {
    numOfCartItems += 1;
    notifyListeners();
  }

  void decressCartItemsBadgeNumber() {
    numOfCartItems -= 1;
    notifyListeners();
  }
}
