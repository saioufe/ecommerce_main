import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/payment-first-items.dart';
import 'package:ecommerce_template/screens/payment-second-pay-address.dart';
import 'package:ecommerce_template/screens/payment-third-confirm.dart';
import 'package:ecommerce_template/widgets/cart-item.dart';
import 'package:ecommerce_template/widgets/cart-no-products.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';

import '../ecommerce_icons_icons.dart';

class CartScreen extends StatefulWidget {
  final PersistentTabController controller;

  CartScreen({this.controller});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  PageController c = new PageController();

  String thePage = "البيانات";
  int pageNumber = 0;

  void setThePageSetUppers(int page) {
    pageNumber = page;
    setState(() {
      if (page == 0) {
        thePage = "السلة";
      } else if (page == 1) {
        thePage = "العنوان والدفع";
      } else {
        thePage = "التاكيد";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context);

    final carPro = Provider.of<CartProvider>(context, listen: false);

    List<Widget> theGoldCarsWidget = [
      PaymentFirstItems(
        c: c,
      ),
      PaymentSecondPayAddress(
        c: c,
      ),
      PaymentThirdConfirm(c: c, controller: widget.controller),
    ];

    return carPro.loadedAllCartItems == null
        ? FutureBuilder(
            future: carPro.getCartItems(),
            builder: (ctx, authResultSnap) {
              if (authResultSnap.connectionState == ConnectionState.waiting) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (authResultSnap.hasError) {
                Center(
                  child: Text(
                    lang.translation['checkInternet']
                        [Languages.selectedLanguage],
                  ),
                );
                return RaisedButton(
                  onPressed: () {
                    setState(() {
                      //other.getUserLocation();
                    });
                    print(authResultSnap.error.toString());
                  },
                  child: Text(
                      lang.translation['checkInternet']
                          [Languages.selectedLanguage],
                      style: TextStyle(color: Colors.black)),
                );
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 25, bottom: 20),
                          width: MediaQuery.of(context).size.width / 1.1,
                          //alignment: Alignment.centerRight,
                          child: Text(
                            lang.translation['shoppingBasket']
                                [Languages.selectedLanguage],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).bottomAppBarColor,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                lang.translation['cartTitle']
                                    [Languages.selectedLanguage],
                                style: TextStyle(
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                              onPressed: pageNumber >= 0
                                  ? () {
                                      c.jumpToPage(0);
                                    }
                                  : null,
                            ),
                            SizedBox(
                              width: 20,
                              child: Divider(
                                thickness: 3,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            FlatButton(
                              child: Text(
                                lang.translation['addressAndPaying']
                                    [Languages.selectedLanguage],
                                style: TextStyle(
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                              onPressed: pageNumber >= 1
                                  ? () {
                                      c.jumpToPage(1);
                                    }
                                  : null,
                            ),
                            SizedBox(
                              width: 20,
                              child: Divider(
                                thickness: 3,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            FlatButton(
                              child: Text(
                                lang.translation['Confirmation']
                                    [Languages.selectedLanguage],
                                style: TextStyle(
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                              onPressed: pageNumber >= 2
                                  ? () {
                                      c.jumpToPage(2);
                                    }
                                  : null,
                            ),
                          ],
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height / 1.45,
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: c,
                            physics: NeverScrollableScrollPhysics(),
                            children: theGoldCarsWidget,
                            onPageChanged: (page) {
                              setThePageSetUppers(page);
                            },
                          ),
                        ),

                        SizedBox(
                          height: 100,
                        ),
                        //CartNoProducts(),
                      ],
                    ),
                  ),
                );
              }
            })
        : carPro.numOfCartItems != 0
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 20),
                        width: MediaQuery.of(context).size.width / 1.1,
                        //alignment: Alignment.centerRight,
                        child: Text(
                          lang.translation['shoppingBasket']
                              [Languages.selectedLanguage],
                          textAlign: Languages.selectedLanguage == 0
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              lang.translation['cartTitle']
                                  [Languages.selectedLanguage],
                              style: TextStyle(
                                color: Theme.of(context).bottomAppBarColor,
                              ),
                            ),
                            onPressed: pageNumber >= 0
                                ? () {
                                    c.jumpToPage(0);
                                  }
                                : null,
                          ),
                          SizedBox(
                            width: 20,
                            child: Divider(
                              thickness: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              lang.translation['addressAndPaying']
                                  [Languages.selectedLanguage],
                              style: TextStyle(
                                color: Theme.of(context).bottomAppBarColor,
                              ),
                            ),
                            onPressed: pageNumber >= 1
                                ? () {
                                    c.jumpToPage(1);
                                  }
                                : null,
                          ),
                          SizedBox(
                            width: 20,
                            child: Divider(
                              thickness: 3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              lang.translation['Confirmation']
                                  [Languages.selectedLanguage],
                              style: TextStyle(
                                color: Theme.of(context).bottomAppBarColor,
                              ),
                            ),
                            onPressed: pageNumber >= 2
                                ? () {
                                    c.jumpToPage(2);
                                  }
                                : null,
                          ),
                        ],
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height / 1.45,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: c,
                          physics: new NeverScrollableScrollPhysics(),
                          children: theGoldCarsWidget,
                          onPageChanged: (page) {
                            setThePageSetUppers(page);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 100,
                      ),
                      //CartNoProducts(),
                    ],
                  ),
                ),
              )
            : CartNoProducts(
                controller: widget.controller,
              );
  }
}
