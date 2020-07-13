import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/widgets/color-product-circle.dart';
import 'package:ecommerce_template/widgets/size-product-box.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductColorSizePressed extends StatefulWidget {
  final ProductShow product;
  ProductColorSizePressed({this.product});

  @override
  _ProductColorSizePressedState createState() =>
      _ProductColorSizePressedState();
}

class _ProductColorSizePressedState extends State<ProductColorSizePressed> {
  @override
  Widget build(BuildContext context) {
    final allposts = Provider.of<AllProviders>(context, listen: true);
    final lang = Provider.of<Languages>(context);

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 0.3, // has the effect of extending the shadow
            offset: Offset(
              0, // horizontal, move right 10
              0, // vertical, move down 10
            ),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: AllProviders.dataOfflineAllProductsColors == null
                            ? FutureBuilder(
                                future: allposts
                                    .fetchDataProductColors(widget.product.id),
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
                                          style:
                                              TextStyle(color: Colors.black)),
                                    );
                                  } else {
                                    return Row(
                                        children:
                                            allposts.colorList.map((item) {
                                      final hexCode = item.replaceAll('#', '');
                                      final color = Color(
                                          int.parse('FF$hexCode', radix: 16));

                                      return ColorProductCircle(
                                        color: color,
                                      );
                                    }).toList());
                                  }
                                })
                            : Row(
                                children: allposts.colorList.map((item) {
                                final hexCode = item.replaceAll('#', '');
                                final color =
                                    Color(int.parse('FF$hexCode', radix: 16));

                                return ColorProductCircle(
                                  color: color,
                                );
                              }).toList()),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    lang.translation['ColorTitle'][Languages.selectedLanguage],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'tajawal',
                        color: Theme.of(context).bottomAppBarColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            endIndent: 40,
            indent: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: allposts.getSizes(widget.product.id),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    lang.translation['sizeTitle'][Languages.selectedLanguage],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'tajawal',
                        color: Theme.of(context).bottomAppBarColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            endIndent: 40,
            indent: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 15, top: 13),
                        child: Text(
                            "${lang.translation['remainsTitle'][Languages.selectedLanguage]} ${allposts.selectedQuantity}"),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 40),
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (AllProviders.selectedQuintity2
                                            .toString() !=
                                        allposts.selectedQuantity) {
                                      AllProviders.selectedQuintity2 += 1;
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.blueAccent.withOpacity(0.1),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AllProviders.selectedQuintity2.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).bottomAppBarColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (AllProviders.selectedQuintity2 != 1) {
                                      AllProviders.selectedQuintity2 -= 1;
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.blueAccent.withOpacity(0.1),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          // DropdownButton<String>(
                          //     icon: Icon(Icons.control_point),
                          //     iconSize: 14,
                          //     iconEnabledColor: Theme.of(context).primaryColor,
                          //     iconDisabledColor: Colors.redAccent,
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         color: Theme.of(context).bottomAppBarColor),
                          //     value: _selectedQuintity,
                          //     items: <String>[
                          //       '1',
                          //       '2',
                          //       '3',
                          //       '4',
                          //       '5',
                          //       '6',
                          //       '7',
                          //       '8',
                          //       '9',
                          //       '10',
                          //     ].map((String value) {
                          //       return new DropdownMenuItem<String>(
                          //         value: value,
                          //         child: new Text(value),
                          //       );
                          //     }).toList(),
                          //     onChanged: (newValue) {
                          //       setState(() {
                          //         _selectedQuintity = newValue;
                          //       });
                          //     }),
                          ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    lang.translation['quantityTitle']
                        [Languages.selectedLanguage],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'tajawal',
                        color: Theme.of(context).bottomAppBarColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
