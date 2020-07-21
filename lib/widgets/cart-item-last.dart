import 'package:ecommerce_template/models/cartItemModel.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:flutter/material.dart';

class CartItemLast extends StatelessWidget {
  final CartItemModel cartItem;
  CartItemLast(this.cartItem);
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
                  AllProviders.numToString(cartItem.productPrice),
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
                        cartItem.product.title,
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
                        cartItem.product.noColor != '1'
                            ? Container(
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
                                        color: cartItem.productColor,
                                        shape: BoxShape.circle),
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        cartItem.product.noColor != '1'
                            ? Container(
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
                                    padding: EdgeInsets.only(
                                        top: 8, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle),
                                    child: Center(
                                        child: Text(
                                      cartItem.productSize,
                                      style: TextStyle(fontSize: 13),
                                      textAlign: TextAlign.center,
                                    )),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.rectangle),
                          child: Center(
                              child: Text(
                            "${cartItem.productQuantity} X",
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
