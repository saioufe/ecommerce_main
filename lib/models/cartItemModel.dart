import 'package:ecommerce_template/models/Product-show.dart';
import 'package:flutter/material.dart';

class CartItemModel {
  final String id;
  final String product_id;
  final ProductShow product;
  final String productPrice;
  final String productSize;
  final Color productColor;
  final String productQuantity;

  CartItemModel({
    this.id,
    @required this.product_id,
    this.product,
    this.productPrice,
    this.productSize,
    this.productColor,
    this.productQuantity,
  });

}
