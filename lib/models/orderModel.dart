import 'package:flutter/material.dart';

class OrderModel {
  final String id;
  final List<String> productsName;
  final List<String> colorsNames;
  final List<String> sizes;
  final List<String> quantities;
  final String phone;
  final String address;
  final String promocode;
  final String price;
  final String name;
  final String date;
  final String message;
  final String status;

  OrderModel({
    this.id,
    this.productsName,
    this.colorsNames,
    @required this.sizes,
    this.quantities,
    this.phone,
    this.address,
    this.promocode,
    this.price,
    this.name,
    this.date,
    this.message,
    this.status,
  });
}
