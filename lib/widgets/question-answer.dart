import 'package:flutter/material.dart';

class QuestionAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.help_outline,
              color: Colors.grey,
            ),
            Container(
              width: 200,
              child: Text(
                "هنا يتم كتابة السؤال المرغوب الاجابة عليه",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
            Container(
              width: 200,
              child: Text(
                "هنا يتم الاجابة على السؤال المطروح",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
