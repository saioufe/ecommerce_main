import 'package:flutter/material.dart';

class CartItemLast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 100,
          width: MediaQuery.of(context).size.width / 1.1,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0.2,
                  blurRadius: 1.9)
            ],
            border: Border(
              top: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            // borderRadius: BorderRadius.all(
            //   Radius.circular(6),
            // ),
          ),
          child: Container(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "11,123 IQD",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Text(
                        " اسم المنتج المختار اسم المنتج المختار اسم المنتج المختار",
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).bottomAppBarColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Container(
                    //     width: 150,
                    //     child: Divider(
                    //       thickness: 3,
                    //       color: Theme.of(context).primaryColor,
                    //     )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                        Container(
                          padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.rectangle),
                          child: Center(
                              child: Text(
                            " x 1 ",
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
