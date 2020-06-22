import 'package:ecommerce_template/screens/payment-first-items.dart';
import 'package:ecommerce_template/screens/payment-second-pay-address.dart';
import 'package:ecommerce_template/screens/payment-third-confirm.dart';
import 'package:ecommerce_template/widgets/cart-item.dart';
import 'package:ecommerce_template/widgets/cart-no-products.dart';
import 'package:flutter/material.dart';

import '../ecommerce_icons_icons.dart';

class CartScreen extends StatefulWidget {
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
    List<Widget> theGoldCarsWidget = [
      PaymentFirstItems(
        c: c,
      ),
      PaymentSecondPayAddress(
        c: c,
      ),
      PaymentThirdConfirm(c: c),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 20),
              width: MediaQuery.of(context).size.width / 1.1,
              //alignment: Alignment.centerRight,
              child: Text(
                "سلة المشتريات",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("السلة"),
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
                  child: Text("العنوان والدفع"),
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
                  child: Text("التاكيد"),
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
                // physics: new NeverScrollableScrollPhysics(),
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
}
