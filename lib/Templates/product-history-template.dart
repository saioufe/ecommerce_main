import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/Product.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductHistoryTemplate extends StatefulWidget {
  final Product product;
  ProductHistoryTemplate({this.product});
  @override
  _ProductHistoryTemplateState createState() => _ProductHistoryTemplateState();
}

class _ProductHistoryTemplateState extends State<ProductHistoryTemplate> {
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);
    return InkWell(
      onTap: () {
        setState(() {
          allPro.NavBarShow(false);
        });

        // Navigator.of(context)
        //     .pushNamed(PressedProduct.routeName, arguments: widget.product);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PressedProduct(product: widget.product),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 1.0,
                    offset: Offset(0, 2),
                    spreadRadius: 0.2)
              ]),
          child: Stack(
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                child: Image.asset(
                  "assets/images/${widget.product.images}",
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      LikeButton(
                        isLiked: widget.product.favorite,
                        size: 30,
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
                                : Colors.white.withOpacity(0.8),
                            size: 30,
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "${widget.product.price} IQD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
