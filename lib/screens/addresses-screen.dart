import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/Templates/searched-word-history.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/application.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/screens/add-address-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ecommerce_icons_icons.dart';

class AddressesScreen extends StatefulWidget {
  final String searchInitial;

  AddressesScreen({this.searchInitial});
  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    CartProvider.loadedaddress = null;
    CartProvider.once3 = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    // appProvider.sharePrefsContaine("search");
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 20, right: 20),
                      //width: MediaQuery.of(context).size.width,
                      //alignment: Alignment.centerRight,
                      child: Text(
                        "عناوين التوصيل",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: cartProvider.getAddress(),
                  builder: (ctx, authResultSnap) {
                    if (authResultSnap.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (authResultSnap.hasError) {
                      Center(
                        child: Text("تفقد من الاتصال بلانترنت"),
                      );
                      return RaisedButton(
                        onPressed: () {
                          setState(() {
                            //other.getUserLocation();
                          });
                          print(authResultSnap.error.toString());
                        },
                        child: Text("تفقد من الاتصال بلانترنت",
                            style: TextStyle(color: Colors.black)),
                      );
                    } else {
                      if (cartProvider.noAddress == false) {
                        return Column(
                          children: CartProvider.loadedaddress.map((addres) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: AddressOrderTemplate(addres, true),
                            );
                          }).toList(),
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                  }),
              cartProvider.noAddress == true
                  ? Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "ليس هناك اي عنوان مدرج , يرجى اضافة عنوان جديد",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .bottomAppBarColor
                                    .withOpacity(0.4),
                              ),
                            ),
                            Icon(
                              Icons.pin_drop,
                              size: 40,
                              color: Theme.of(context)
                                  .bottomAppBarColor
                                  .withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              Container(
                margin: EdgeInsets.only(top: 10 , bottom: 140),
                child: RaisedButton(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "اضافة عنوان جديد",
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressScreen(),
                        ));
                    //controller.jumpToTab(4);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
