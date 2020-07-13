import 'package:flutter/material.dart';

class ProductShow {
  final String id;
  final String title;
  final String titleEngilsh;
  final String description;
  final String descriptionEnglish;
  final String mainCategory;
  final List<String> subCategories;
  final bool favorite;
  final String image;
  final String price;
  final String discount;
  final double discountPercentage;
  final String isQuestion;
  final String date;

  ProductShow({
    this.id,
    this.title,
    this.titleEngilsh,
    this.description,
    this.descriptionEnglish,
    this.mainCategory,
    this.subCategories,
    this.favorite,
    this.image,
    this.price,
    this.discount,
    this.discountPercentage,
    this.isQuestion,
    @required this.date
  });
}
