import 'package:ecommerce_template/models/News.dart';
import 'package:flutter/material.dart';

class NewsHomeTemplate extends StatelessWidget {
  final News news;
  NewsHomeTemplate({this.news});
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Image.asset(
              "assets/images/${news.image}",
              width: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
