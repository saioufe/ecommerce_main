import 'package:ecommerce_template/Templates/searched-word-history.dart';
import 'package:flutter/material.dart';

import '../ecommerce_icons_icons.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 20),
            width: MediaQuery.of(context).size.width / 1.1,
            //alignment: Alignment.centerRight,
            child: Text(
              "البحث",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            width: MediaQuery.of(context).size.width / 1.1,
            child: TextField(
              textAlign: TextAlign.right,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ابحث عن الاف المنتجات بضغطة زر',
                  labelStyle: TextStyle(fontSize: 13),
                  prefixIcon: Icon(
                    EcommerceIcons.magnifying_glass,
                    color: Theme.of(context).bottomAppBarColor,
                    size: 20,
                  ),
                  suffixStyle:
                      TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          "حذف",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "تاريخ البحث",
                        style: TextStyle(
                          fontSize: 19,
                          color: Theme.of(context).bottomAppBarColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SearchedWorldHistory(),
                      SearchedWorldHistory(),
                      SearchedWorldHistory(),
                      SearchedWorldHistory(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1.6,
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Icon(
          //             Icons.search,
          //             size: 80,
          //             color:
          //                 Theme.of(context).bottomAppBarColor.withOpacity(0.2),
          //           ),
          //           Text(
          //             "لم تبحث عن اي منتج الى حد هذه اللحظة لنبدا الان  - سوف نساعدك.",
          //             textDirection: TextDirection.rtl,
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               fontSize: 20,
          //               color: Theme.of(context)
          //                   .bottomAppBarColor
          //                   .withOpacity(0.4),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
