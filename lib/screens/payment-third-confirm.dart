import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/are-you-sure.dart';
import 'package:ecommerce_template/screens/order-done-screen.dart';
import 'package:ecommerce_template/widgets/cart-item-last.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

TextEditingController myController = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
double buttonWidth = 1.1;
bool isLoading = false;

class PaymentThirdConfirm extends StatefulWidget {
  PageController c;
  final PersistentTabController controller;
  PaymentThirdConfirm({this.c, this.controller});

  @override
  _PaymentThirdConfirmState createState() => _PaymentThirdConfirmState();
}

class _PaymentThirdConfirmState extends State<PaymentThirdConfirm> {
  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<CartProvider>(context, listen: true);
    final lang = Provider.of<Languages>(context);

    return Scaffold(
      key: _scaffoldKey2,
      body: Container(
        //width: MediaQuery.of(context).size.width / 1.1,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                lang.translation['ConfirmeDate'][Languages.selectedLanguage],
              ),
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
                        lang.translation['cartTitle']
                            [Languages.selectedLanguage],
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<CartProvider>(
                builder: (ctx, data, _) {
                  return Column(
                    children: data.loadedAllCartItems.map((item) {
                      return CartItemLast(item);
                    }).toList(),
                  );
                },
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
                        EcommerceIcons.placeholder,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      Text(
                        lang.translation['shippingAddressTitle']
                            [Languages.selectedLanguage],
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AddressOrderTemplate(cartPro.selectedAddress, false),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      height: 58,
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          lang.translation['Confirmation']
                              [Languages.selectedLanguage],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      cartPro.getPromocodes(myController.text).then((value) {
                        if (cartPro.lastTotalPrice <=
                            num.parse(cartPro.promocodeValue)) {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    lang.translation['CantApplyPromo']
                                        [Languages.selectedLanguage],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              elevation: 2,
                            ),
                          );
                        } else {
                          if (cartPro.promocodeValue != '0') {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      lang.translation['promocodeCorrect']
                                          [Languages.selectedLanguage],
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                elevation: 2,
                              ),
                            );
                          } else if (cartPro.promocodeValue == '0') {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.warning,
                                      color: Colors.redAccent,
                                    ),
                                    Container(
                                      child: Text(
                                        lang.translation['wrongPromocode']
                                            [Languages.selectedLanguage],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                elevation: 2,
                              ),
                            );
                          }
                        }
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: TextField(
                      controller: myController,
                      onSubmitted: (value) {
                        //appProvider.search(value, context);
                      },
                      onChanged: (value) {
                        if (value == "") {
                          // appProvider.search(value, context);
                        }
                      },
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: lang.translation['promocode']
                              [Languages.selectedLanguage],
                          hintStyle: TextStyle(
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                          labelStyle: TextStyle(fontSize: 23),
                          suffixStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ],
              ),
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
                          "${cartPro.lastTotalPrice.toStringAsFixed(3)} IQD",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                        ),
                        Text(
                          lang.translation['price'][Languages.selectedLanguage],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                          cartPro.selectedShipPrice,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                        ),
                        Text(
                          lang.translation['delivery']
                              [Languages.selectedLanguage],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                          double.parse(cartPro.promocodeValue) <
                                  cartPro.lastTotalPrice
                              ? cartPro.promocodeValue
                              : "0",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                        ),
                        Text(
                          lang.translation['discount']
                              [Languages.selectedLanguage],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
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
                          cartPro
                              .getTotalPrice(
                                  double.parse(cartPro.promocodeValue))
                              .toStringAsFixed(3),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                        ),
                        Text(
                          lang.translation['total'][Languages.selectedLanguage],
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
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
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width / buttonWidth,
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Shimmer.fromColors(
                    baseColor: Theme.of(context).primaryColor,
                    highlightColor: Colors.white,
                    period: Duration(milliseconds: 800),
                    child: isLoading == false
                        ? Text(
                            lang.translation['confirmeTheBut']
                                [Languages.selectedLanguage],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(),
                  )),
                ),
                onPressed: () {
                  setState(() {
                    buttonWidth = 2;
                    isLoading = true;
                  });

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AreYouSure(
                  //         controller: widget.controller,
                  //       ),
                  //     ));

                  cartPro.sendOrder2(cartPro.promocodeValue).then((value) {
                    buttonWidth = 1.1;
                    isLoading = false;

                    if (cartPro.isBuyed == true) {
                      cartPro.isBuyed = false;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDone(
                              controller: widget.controller,
                            ),
                          ));
                    } else {
                      print("suck it");
                    }

                    //widget.controller.jumpToTab(4);
                  });
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
