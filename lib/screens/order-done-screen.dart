import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';

class OrderDone extends StatelessWidget {
  final PersistentTabController controller;
  OrderDone({this.controller});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Theme.of(context).bottomAppBarColor.withOpacity(0.2),
                ),
                Text(
                  "تمت العملية بنجاح يمكنك متابعة الطلب من الصفحة الشخصية",
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
                      "حسنا",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      controller.jumpToTab(0);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
