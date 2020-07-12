import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';

class CartNoProducts extends StatelessWidget {
  final PersistentTabController controller;

  CartNoProducts({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              size: 80,
              color: Theme.of(context).bottomAppBarColor.withOpacity(0.2),
            ),
            Text(
              "يبدو من انك لم تضف اي منتج لسلة المشتريات , ابدا في التسوق لملئ السلة",
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
                  "ابد التسوق",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  controller.jumpToTab(4);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
