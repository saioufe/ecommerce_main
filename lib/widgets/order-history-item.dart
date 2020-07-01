import 'package:ecommerce_template/screens/old-order-template.dart';
import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OldOrderTemplate(),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2.0,
                blurRadius: 8,
              ),
            ]
            // border: Border(
            //   bottom: BorderSide(
            //     color: Colors.grey.withOpacity(0.3),
            //     width: 2,
            //   ),
            // ),
            ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.verified_user,
                color: Colors.white,
              ),
              radius: 27,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Order #20180304",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).bottomAppBarColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Preparing",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "View 3 items",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.greenAccent,
                  ),
                ),
                Text(
                  
                  
                  "04 july,2018 | 11:35 am",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
