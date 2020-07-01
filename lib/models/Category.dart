import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final List<String> subCategories;

  Category({
    this.id,
    this.name,
    this.image,
    this.subCategories,
  });
}
