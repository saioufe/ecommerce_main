import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductMainTemplate extends StatefulWidget {
  final ProductShow product;
  final bool isMain;
  ProductMainTemplate({@required this.product, @required this.isMain});

  @override
  _ProductMainTemplateState createState() => _ProductMainTemplateState();
}

class _ProductMainTemplateState extends State<ProductMainTemplate> {
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context, listen: false);

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      print(widget.product.id);
      Future.delayed(const Duration(milliseconds: 500), () {
        allPro.setFavoriteProduct(widget.product, isLiked);
      });
      return !isLiked;
    }

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
              builder: (context) => PressedProduct(
                product: widget.product,
                isMain: widget.isMain,
              ),
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
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Stack(children: <Widget>[
                  Hero(
                    tag: widget.product.id,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      height: 120,
                      width: 200,
                      image: NetworkImage(
                          "${AllProviders.hostName}/images/products/${widget.product.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  widget.product.discount != '0'
                      ? Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(10),
                              )),
                          child: Text(
                            "${widget.product.discountPercentage.toStringAsFixed(1)} %",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                  bottom: 5,
                ),
                child: Text(
                  widget.product.title,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    LikeButton(
                      size: 30,
                      isLiked: allPro.favoriteList[widget.product.id],
                      circleColor: CircleColor(
                          start: Theme.of(context).primaryColor,
                          end: Theme.of(context).primaryColor),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Theme.of(context).primaryColor,
                        dotSecondaryColor: Theme.of(context).primaryColor,
                      ),
                      onTap: onLikeButtonTapped,
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
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        widget.product.discount == '0'
                            ? "${widget.product.price} IQD"
                            : "${widget.product.discount} IQD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
