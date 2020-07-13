import 'dart:convert';

import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flushbar/flushbar.dart';

import 'languages.dart';

class ApplicationProvider extends ChangeNotifier {
  AllProviders _allProviders;
  ApplicationProvider(this._allProviders);

  static const String hostName = "http://10.0.2.2/ecommerceTemplate";

  String aboutus = '';
  String facebook = '';
  String insta = '';
  String twitter = '';
  String youtube = '';
  List data = [];
  Future<void> fetchDataAboutUs() async {
    final response = await http.post('$hostName/get-aboutus-flutter.php');

    data = json.decode(response.body);
    if (data == null) {
      return;
    }

    data.forEach((newsId) {
      aboutus = newsId['aboutus'];
      facebook = newsId['facebook'];
      insta = newsId['instagram'];
      twitter = newsId['twitter'];
      youtube = newsId['youtube'];
    });

    notifyListeners();
  }

  List data2 = [];
  bool searchResultEmply = false;
  List<String> oldSearchResult = [];
  List<ProductShow> searchProducts = [];
  String tempSearch = "";

  bool isContainKey = false;
  void sharePrefsContaine(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      isContainKey = true;
    } else {
      isContainKey = false;
    }
  }

  void deleteSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tempSearch = '';
    oldSearchResult = [];
    prefs.remove("search");
    notifyListeners();
  }

  void searchResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('search')) {
      oldSearchResult = prefs.getString('search').split(",");
    }
    notifyListeners();
  }

  Future<void> search(String searchText, BuildContext context , Languages lang) async {
    tempSearch = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.remove('search');
    searchProducts = [];
    searchResultEmply = false;
    if (searchText != "") {
      final response = await http.post('$hostName/search.php', body: {
        'searchText': searchText,
      });

      data2 = json.decode(response.body);
      if (data2.length == 0) {
        Flushbar(
          title: lang.translation['noSearchResult']
                  [Languages.selectedLanguage],
          message: lang.translation['researchAgain']
                  [Languages.selectedLanguage],
          barBlur: 0.4,
          duration: Duration(milliseconds: 3000),
          backgroundColor: Theme.of(context).primaryColor,
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
        searchResultEmply = true;
        return null;
      }

      if (prefs.containsKey('search')) {
        tempSearch = prefs.getString("search") + ',' + searchText;
        prefs.setString('search', "$tempSearch");

        oldSearchResult = prefs.getString('search').split(",");
      } else {
        prefs.setString('search', "$searchText");
        oldSearchResult.add(prefs.getString('search'));
      }

      _allProviders.allProducts.forEach((newsId) {
        data2.forEach((element) {
          if (element['id'] == newsId.id) {
            // print("saif search");
            searchProducts.add(newsId);
          }
        });
      });

      notifyListeners();
    } else {
      notifyListeners();
    }
  }
}
