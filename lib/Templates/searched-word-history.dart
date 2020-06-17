import 'package:flutter/material.dart';

class SearchedWorldHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.centerRight,
      width: MediaQuery.of(context).size.width / 1.1,
      child: Text(
        "حذاء",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
      ),
    );
  }
}
