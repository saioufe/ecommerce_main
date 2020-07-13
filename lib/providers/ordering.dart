import 'dart:convert';

import 'package:ecommerce_template/models/address.dart';
import 'package:ecommerce_template/models/orderModel.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'allProviders.dart';

class Ordering extends ChangeNotifier {
  List orders = [];
  List<OrderModel> loadedOrders;
  bool once = false;

  List<OrderModel> _allorders = [];
  List<OrderModel> get allorders {
    return _allorders;
  }

  Future<void> getOrders() async {
    if (once == false) {
      List<OrderModel> loadedCities = [];
      final response = await http.post(
          '${AllProviders.hostName}/get-orders-history-flutter.php',
          body: {
            'userId': UserProvider.userId.toString(),
          });

      orders = json.decode(response.body);

      orders.forEach((newsId) {
        loadedCities.add(OrderModel(
          id: newsId['id'],
          productsName: newsId['product_ids'].toString().split(','),
          colorsNames: newsId['sizes_id'].toString().split(","),
          quantities: newsId['quantities'].toString().split(','),
          sizes: newsId['size'].toString().split(','),
          phone: newsId['phone'],
          address: newsId['address'],
          promocode: newsId['promocode'],
          price: newsId['price'],
          name: newsId['name'],
          date: newsId['date'],
          message: newsId['message'],
          status: newsId['status'],
        ));
      });
      once = true;
      _allorders = loadedCities;
      notifyListeners();
    }
  }



}
