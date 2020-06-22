import 'package:ecommerce_template/widgets/cart-item.dart';
import 'package:flutter/material.dart';

class PaymentFirstItems extends StatelessWidget {
  PageController c;
  PaymentFirstItems({this.c});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          children: <Widget>[

            CartItem(),

            SizedBox(
              height: 100,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "متابعة",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onPressed: () {
                c.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
