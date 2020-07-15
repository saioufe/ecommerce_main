import 'package:flutter/material.dart';

class News {
  final String id;
  final String title;
  final String text;
  final String titleEnglish;
  final String textEnglish;
  final String image;
  final String date;
  final String showPosts;


  News({
    this.id,
    this.title,
    this.text,
    this.titleEnglish,
    this.textEnglish,
    this.image,
    this.date,
    @required this.showPosts,
  });
}
