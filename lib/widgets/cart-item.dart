import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  String _selectedQuintity = "1";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      clipBehavior: Clip.antiAlias,
      //   child: Container(
      //     width: MediaQuery.of(context).size.width / 1.1,

      //     // padding: EdgeInsets.all(10),
      //     color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: 120,
                          child: Text(
                            "  اسم المنتج اسم المنتج اسم المنتج اسم المنتج   اسم المنتج  ",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).bottomAppBarColor),
                          ),
                        ),
                      ),
                      Text(" 150,000 IQD",
                          style: TextStyle(
                              fontSize: 19,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    shape: BoxShape.circle),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 8, left: 5, right: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle),
                                child: Center(
                                    child: Text(
                                  "XL",
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/product6.jpg",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
