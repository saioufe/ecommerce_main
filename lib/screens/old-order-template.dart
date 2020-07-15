import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:ecommerce_template/models/orderModel.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/widgets/size-product-box.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class OldOrderTemplate extends StatelessWidget {
  final OrderModel order;
  OldOrderTemplate({this.order});
  @override
  int index = 0;
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              lang.translation['orderDetails'][Languages.selectedLanguage],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(3),
                    // ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: Languages.selectedLanguage == 0
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lang.translation['orderDetails']
                            [Languages.selectedLanguage],
                      ),

                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Order id : #${order.id}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                              Text(
                                "Date : ${order.date}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Center(
                            child: Text(
                              "IQD ${order.price}",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        lang.translation['orderAddress']
                            [Languages.selectedLanguage],
                      ),

                      Divider(),
                      Text(
                        "${order.address}",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        lang.translation['orderProducts']
                            [Languages.selectedLanguage],
                      ),

                      Divider(),
                      Column(
                          children: order.productsName
                              .sublist(0, order.productsName.length - 1)
                              .map((name) {
                        index++;
                        final hexCode =
                            order.colorsNames[index - 1].replaceAll('#', '');
                        final color = Color(int.parse('FF$hexCode', radix: 16));
                        return Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "$name X ${order.quantities[index - 1]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: color,
                                ),
                                SizedBox(
                                  height: 7,
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    // boxShadow: <BoxShadow>[
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.9),
                                    //     spreadRadius: 0.5,
                                    //     blurRadius: 1.5,
                                    //   ),
                                    // ],
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.04),
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
                                        order.sizes[index - 1],
                                        style: TextStyle(fontSize: 19),
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ),
                                ),
                                // Text(
                                //   "${}",
                                //   style: TextStyle(fontSize: 18),
                                // ),
                              ],
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                              endIndent: 100,
                              indent: 100,
                            )
                          ],
                        );
                      }).toList()),
                      SizedBox(
                        height: 10,
                      ),
                      // AddressOrderTemplate(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    // border: Border(
                    //   top: BorderSide(
                    //     color: Colors.grey.withOpacity(0.3),
                    //     width: 2,
                    //   ),
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: Languages.selectedLanguage == 0
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lang.translation['FollowOrder']
                            [Languages.selectedLanguage],
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 20),
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Column(
                                  children:
                                      buildOrderStatus(order.status).toList()
                                  //here is the Item should be TODO
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        lang.translation['moreDetails']
                            [Languages.selectedLanguage],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.message != ""
                            ? "${order.message}"
                            : "لا توجد رسائل",
                        style: TextStyle(fontSize: 16, color: Colors.redAccent),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> orderStatusWidgets = [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 12,
            ),
            Container(
              height: 20,
              child: VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Text(Languages.selectedLanguage == 0
            ? "تم استلام طلبك"
            : 'Order is Pending'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.brown,
              radius: 12,
            ),
            Container(
              height: 20,
              child: VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Text(Languages.selectedLanguage == 0
            ? "الطلب قيد التجهيز"
            : 'Processing Order'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.yellow,
              radius: 12,
            ),
            Container(
              height: 20,
              child: VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Text(Languages.selectedLanguage == 0
            ? "الطلب قيد التسليم"
            : 'Delivering Order'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 12,
            ),
            Container(
              height: 20,
              child: VerticalDivider(
                width: 12,
                thickness: 2,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Text(Languages.selectedLanguage == 0 ? "تم التسليم" : 'Delivered'),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 12,
            ),
          ],
        ),
        Text(Languages.selectedLanguage == 0
            ? "تم رفض الطلب"
            : 'order Rejected'),
      ],
    ),
  ];
  List<Widget> buildOrderStatus(String orderStatus) {
    if (orderStatus == "Order is rejected") {
      buildList.add(orderStatusWidgets[4]);

      return buildList;
    }

    if (orderStatus == "Pending") {
      for (var i = 0; i < orderStatusWidgets.length; i++) {
        buildList.add(orderStatusWidgets[i]);
        if (i == 0) {
          break;
        }
      }
    }
    if (orderStatus == "Processing order") {
      for (var i = 0; i < orderStatusWidgets.length; i++) {
        buildList.add(orderStatusWidgets[i]);
        if (i == 1) {
          break;
        }
      }
    }
    if (orderStatus == "Delivering order") {
      for (var i = 0; i < orderStatusWidgets.length; i++) {
        buildList.add(orderStatusWidgets[i]);
        if (i == 2) {
          break;
        }
      }
    }
    if (orderStatus == "Delivered") {
      for (var i = 0; i < orderStatusWidgets.length; i++) {
        buildList.add(orderStatusWidgets[i]);
        if (i == 3) {
          break;
        }
      }
    }

    return buildList;
  }

  List<Widget> buildList = [];
}
