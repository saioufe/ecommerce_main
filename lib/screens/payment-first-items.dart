import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/widgets/cart-item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentFirstItems extends StatefulWidget {
  PageController c;
  PaymentFirstItems({this.c});

  @override
  _PaymentFirstItemsState createState() => _PaymentFirstItemsState();
}

class _PaymentFirstItemsState extends State<PaymentFirstItems> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context);

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          children: <Widget>[
            Consumer<CartProvider>(
              builder: (ctx, data, _) {
                return Column(
                  children: data.loadedAllCartItems.map((item) {
                    return CartItem(item);
                  }).toList(),
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
            RaisedButton(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    lang.translation['continue'][Languages.selectedLanguage],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onPressed: () {
                if (UserProvider.isLogin == true) {
                  widget.c.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                } else {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                        lang.translation['PleaseSignInFirst']
                            [Languages.selectedLanguage],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 35),
                      ),
                      title: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.warning,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                      elevation: 2,
                    ),
                  );
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
