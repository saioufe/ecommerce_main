import 'package:ecommerce_template/models/Product-show.dart';
import 'package:flutter/material.dart';

class SliderModel {
  final String id;
  final String productid;
  final String image;
  final ProductShow productShow;
  final bool hasProduct;
  final int productIndex;

  SliderModel({
    this.id,
    this.productid,
    this.image,
    this.productShow,
    this.hasProduct,
    this.productIndex,
  });
}
