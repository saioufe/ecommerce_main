import 'package:ecommerce_template/models/Product.dart';
import 'package:ecommerce_template/widgets/color-product-circle.dart';
import 'package:ecommerce_template/widgets/size-product-box.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ProductColorSizePressed extends StatefulWidget {
  final Product product;
  ProductColorSizePressed({this.product});

  @override
  _ProductColorSizePressedState createState() =>
      _ProductColorSizePressedState();
}

String _selectedQuintity = "1";

class _ProductColorSizePressedState extends State<ProductColorSizePressed> {
  @override
  Widget build(BuildContext context) {
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
                        child: Row(
                          children: <Widget>[
                            ColorProductCircle(
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 10),
                            ColorProductCircle(
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 10),
                            ColorProductCircle(
                              color: Colors.lightGreen,
                            ),
                            SizedBox(width: 10),
                            ColorProductCircle(
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(width: 10),
                            ColorProductCircle(
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            ColorProductCircle(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    " : اللون",
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
                        child: Row(
                          children: <Widget>[
                            SizeProductBox(
                              sizeText: "24",
                            ),
                            SizedBox(width: 10),
                            SizeProductBox(
                              sizeText: "XXL",
                            ),
                            SizedBox(width: 10),
                            SizeProductBox(
                              sizeText: "Free Size",
                            ),
                            SizedBox(width: 10),
                            SizeProductBox(
                              sizeText: "Free Size",
                            ),
                            SizedBox(width: 10),
                            SizeProductBox(
                              sizeText: "Free",
                            ),
                            SizedBox(width: 10),
                            SizeProductBox(
                              sizeText: "big big big",
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    " : الحجم",
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
                        child: Text("10 متبقي"),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 40),
                        alignment: Alignment.center,
                        child: DropdownButton<String>(
                            icon: Icon(Icons.control_point),
                            iconSize: 14,
                            iconEnabledColor: Theme.of(context).primaryColor,
                            iconDisabledColor: Colors.redAccent,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).bottomAppBarColor),
                            value: _selectedQuintity,
                            items: <String>[
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10'
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedQuintity = newValue;
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: Center(
                  child: Text(
                    " : الكمية",
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
