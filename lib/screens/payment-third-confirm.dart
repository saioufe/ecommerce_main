import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/widgets/cart-item-last.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentThirdConfirm extends StatelessWidget {
  PageController c;
  PaymentThirdConfirm({this.c});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("تاكد من المعلومات"),
            Divider(
              endIndent: 100,
              indent: 100,
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 180,
              margin: EdgeInsets.only(right: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        offset: Offset(0, 5),
                        blurRadius: 0.9)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EcommerceIcons.shopping_basket,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    Text(
                      "السلة",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CartItemLast(),
            Container(
              alignment: Alignment.centerRight,
              width: 180,
              margin: EdgeInsets.only(right: 20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        offset: Offset(0, 5),
                        blurRadius: 0.9)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      EcommerceIcons.placeholder,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    Text(
                      "عنوان السكن",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 19),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AddressOrderTemplate(),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "15,000 IQD",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                      ),
                      Text(
                        " : السعر",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "- 5,000 IQD",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                      ),
                      Text(
                        " : الخصم",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Divider(
                    endIndent: 100,
                    indent: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "10,000 IQD",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                      ),
                      Text(
                        " : المجموع",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor: Colors.white,
                  period: Duration(milliseconds: 800),
                  child: Text(
                    "تاكيد عملية الشراء ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ),
              onPressed: () {
                // widget.c.animateToPage(2,
                //     duration: Duration(milliseconds: 300),
                //     curve: Curves.easeIn);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
