import 'package:ecommerce_template/Templates/address-order-template.dart';
import 'package:flutter/material.dart';

class OldOrderTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "تفاصيل الطلب",
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("تفاصيل الطلب"),
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
                                "Order id : #20180213",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                              ),
                              Text(
                                "Date : 15 may 2020",
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
                              "\$12.14",
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
                      Text("عنوان الطلب"),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      AddressOrderTemplate(),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("تتبع الطلب"),
                      Divider(),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.orangeAccent,
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
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
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
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.redAccent,
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
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top:10 ,left: 20),
                              child: Column(
                                children: <Widget>[
                                  Text("تم استلام طلبك"),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text("الطلب في قيد التجهيز"),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text("الطلب في قيد التسليم"),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text("تم السليم"),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text("تم رفض الطلب"),
                                  SizedBox(
                                    height: 26,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text("المزيد من التفاصيل"),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "شرح عن سبب الغاء الطلب او اي تفاصيل يريد اي يضعها التاجر",
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
}
