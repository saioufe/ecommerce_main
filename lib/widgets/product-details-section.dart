import 'package:ecommerce_template/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ProductDetailsPressed extends StatelessWidget {
  final Product product;
  ProductDetailsPressed({this.product});
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
                    child: Center(
                      child: Text(
                        "${product.price} IQD",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'tajawal',
                            color: Theme.of(context).bottomAppBarColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            "${product.discount} IQD",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'tajawal',
                              color: Theme.of(context).bottomAppBarColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 10,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        margin: EdgeInsets.only(bottom: 8),
                        color: Colors.redAccent.withOpacity(0.3),
                        child: Center(
                          child: Text(
                            "-20%",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              LikeButton(
                size: 30,
                isLiked: product.favorite,
                circleColor: CircleColor(
                    start: Theme.of(context).primaryColor,
                    end: Theme.of(context).primaryColor),
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Theme.of(context).primaryColor,
                  dotSecondaryColor: Theme.of(context).primaryColor,
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.4),
                    size: 30,
                  );
                },
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  "${product.title}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'tajawal',
                      color: Theme.of(context).bottomAppBarColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 25),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
