import 'package:flutter/material.dart';

class CartNoProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              size: 80,
              color: Theme.of(context).bottomAppBarColor.withOpacity(0.2),
            ),
            Text(
              "ليس هناك اي منتجات مضافة الى المفضلات",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.4),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: RaisedButton(
                padding: EdgeInsets.all(12),
                child: Text(
                  "اضف المزيد",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
