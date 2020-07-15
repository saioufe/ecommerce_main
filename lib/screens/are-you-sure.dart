import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';

import 'order-done-screen.dart';

class AreYouSure extends StatelessWidget {
  final PersistentTabController controller;
  AreYouSure({this.controller});
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context);
    final cartPro = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.hourglass_empty,
                  size: 80,
                  color: Theme.of(context).bottomAppBarColor.withOpacity(0.2),
                ),
                Text(
                  "هل انت متاكد",
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
                      lang.translation['OK'][Languages.selectedLanguage],
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    color: Theme.of(context).primaryColor,
                    
                    onPressed: () {
                      cartPro.sendOrder2(cartPro.promocodeValue);
                      // buttonWidth = 1.1;
                      // isLoading = false;



                      //widget.controller.jumpToTab(4);

                      // Languages.selectedLanguage == 0
                      //     ? controller.jumpToTab(0)
                      //     : controller.jumpToTab(4);
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
