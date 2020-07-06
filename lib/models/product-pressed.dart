import 'package:flutter/material.dart';

class ProductPressed {
  final String id;
  final String title;
  final String description;
  final String titleEngilsh;
  final String descriptionEnglish;
  final String mainCategory;
  final List<String> subCategories;
  final bool favorite;
  final List<String> images;
  final List<String> price;
  final List<String> discount;
  final String discountPercentage;
  final List<String> colors;
  final List<String> quantity;

  ProductPressed({
    this.id,
    this.title,
    this.titleEngilsh,
    this.description,
    this.descriptionEnglish,
    this.mainCategory,
    this.subCategories,
    this.favorite,
    this.images,
    this.price,
    this.discount,
    this.discountPercentage,
    this.colors,
    this.quantity,
  });
}
