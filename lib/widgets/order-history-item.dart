import 'package:ecommerce_template/models/orderModel.dart';
import 'package:ecommerce_template/screens/old-order-template.dart';
import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  final OrderModel order;
  OrderHistoryItem({this.order});
  @override
  Color color;
  Widget build(BuildContext context) {
    if (order.status == "Pending") {
      color = Colors.orange;
    } else if (order.status == "Order is rejected") {
      color = Colors.redAccent;
    } else if (order.status == "Delivered") {
      color = Colors.green;
    } else if (order.status == "Delivering order") {
      color = Colors.yellow;
    } else if (order.status == "Processing order") {
      color = Colors.brown;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OldOrderTemplate(order: order),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
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
            Container(
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 5,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Order #${order.id}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${order.status}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "view the ${order.productsName.length -1} items",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "${order.date}",
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
