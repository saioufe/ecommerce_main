import 'package:ecommerce_template/models/city.dart';
import 'package:ecommerce_template/models/country.dart';
import 'package:ecommerce_template/providers/application.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ecommerce_icons_icons.dart';

class AddAddressScreen extends StatefulWidget {
  final String searchInitial;

  AddAddressScreen({this.searchInitial});
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController myControllerName = TextEditingController();
  TextEditingController myControllerPhone = TextEditingController();
  TextEditingController myControllerAddress = TextEditingController();

  String _selectedCountry = "العراق";
  String _selectedCity;
  @override
  Widget build(BuildContext context) {
    //final appProvider = Provider.of<ApplicationProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final lang = Provider.of<Languages>(context);

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
                        lang.translation['addNewShippingAddress']
                            [Languages.selectedLanguage],
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
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    // border: Border.all(color: Theme.of(context).primaryColor),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(0, 2),
                          spreadRadius: 2.0),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextField(
                  controller: myControllerName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: lang.translation['usernameEnter']
                          [Languages.selectedLanguage],
                      hintStyle: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      labelStyle: TextStyle(fontSize: 23),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Theme.of(context).bottomAppBarColor,
                        size: 20,
                      ),
                      suffixStyle:
                          TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(0, 2),
                          spreadRadius: 2.0),
                    ],
                    //border: Border.all(color: Theme.of(context).primaryColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextField(
                  controller: myControllerPhone,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: lang.translation['phoneTitleEnter']
                          [Languages.selectedLanguage],
                      hintStyle: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      labelStyle: TextStyle(fontSize: 23),
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Theme.of(context).bottomAppBarColor,
                        size: 20,
                      ),
                      suffixStyle:
                          TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(0, 2),
                          spreadRadius: 2.0),
                    ],
                    //border: Border.all(color: Theme.of(context).primaryColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextField(
                  controller: myControllerAddress,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: lang.translation['areOrKeyPlease']
                          [Languages.selectedLanguage],
                      hintStyle: TextStyle(
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      labelStyle: TextStyle(fontSize: 23),
                      prefixIcon: Icon(
                        Icons.pin_drop,
                        color: Theme.of(context).bottomAppBarColor,
                        size: 20,
                      ),
                      suffixStyle:
                          TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  lang.translation['conutryTitle'][Languages.selectedLanguage],
                  style: TextStyle(fontSize: 19),
                ),
              ),
              Divider(),
              Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(0, 2),
                            spreadRadius: 2.0),
                      ],
                      //border: Border.all(color: Theme.of(context).primaryColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child:
                      //  cartProvider.loadedCountries == null
                      //     ?
                      FutureBuilder(
                          future: cartProvider.getCountries(),
                          builder: (ctx, authResultSnap) {
                            if (authResultSnap.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
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
                              return DropdownButton<String>(
                                  value: _selectedCountry,
                                  underline: SizedBox(),
                                  icon: SizedBox(),
                                  items: cartProvider.allcountries
                                      .map((Country value) {
                                    return new DropdownMenuItem<String>(
                                      value: value.nameArabic,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          margin: EdgeInsets.only(left: 50),
                                          child: Center(
                                            child: new Text(
                                              value.nameArabic,
                                              textAlign: TextAlign.right,
                                            ),
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      cartProvider.once2 = false;
                                      cartProvider.getCities(newValue);

                                      _selectedCountry = newValue;
                                      _selectedCity = null;
                                    });
                                  });
                            }
                          })),
              SizedBox(
                height: 20,
              ),
              cartProvider.loadedCities == null
                  ? Consumer<CartProvider>(
                      builder: (ctx, value, _) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                lang.translation['cityTitle']
                                    [Languages.selectedLanguage],
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        spreadRadius: 2.0),
                                  ],
                                  //border: Border.all(color: Theme.of(context).primaryColor),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: DropdownButton<String>(
                                  value: _selectedCity,
                                  underline: SizedBox(),
                                  icon: SizedBox(),
                                  items: value.allcities.map((City value) {
                                    return new DropdownMenuItem<String>(
                                      value: value.nameArabic,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          margin: EdgeInsets.only(left: 50),
                                          child: Center(
                                            child: new Text(
                                              value.nameArabic,
                                              textAlign: TextAlign.right,
                                            ),
                                          )),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCity = newValue;
                                    });
                                  }),
                            ),
                          ],
                        );
                      },
                    )
                  : SizedBox(
                      height: 20,
                    ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  lang.translation['insert'][Languages.selectedLanguage],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  if (myControllerName.text != '' &&
                      myControllerAddress.text != '' &&
                      myControllerPhone.text != '' &&
                      _selectedCity != null) {
                    cartProvider
                        .insertAddress(
                      myControllerName.text,
                      myControllerPhone.text.toString(),
                      myControllerAddress.text,
                      _selectedCountry,
                      _selectedCity,
                    )
                        .then((value) {
                      if (value == '0') {
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.warning,
                                  color: Colors.redAccent,
                                ),
                                Container(
                                  child: Text(
                                    lang.translation['only3allowed']
                                        [Languages.selectedLanguage],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            elevation: 2,
                          ),
                        );
                      } else {
                        CartProvider.once3 = false;
                        CartProvider.dataOfflineAllAddress = null;
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
