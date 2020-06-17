import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String price;
  final bool favorite;
  final String images;
  final bool hasDiscount;
  final String discount;

  Product({
    this.id,
    this.title,
    this.price,
    this.favorite,
    this.images,
    this.hasDiscount,
    this.discount,
  });
}
