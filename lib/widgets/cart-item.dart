import 'package:ecommerce_template/models/cartItemModel.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final CartItemModel cartItem;
  CartItem(this.cartItem);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  String _selectedQuintity = "1";

  @override
  Widget build(BuildContext context) {
    final carPro = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      clipBehavior: Clip.antiAlias,
      //   child: Container(
      //     width: MediaQuery.of(context).size.width / 1.1,

      //     // padding: EdgeInsets.all(10),
      //     color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              carPro.deleteCartItems(
                                  widget.cartItem.product.id,
                                  widget.cartItem.productColor.toString(),
                                  widget.cartItem.productSize);
                            });
                          },
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text("${widget.cartItem.productQuantity} x"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: 120,
                          child: Text(
                            Languages.selectedLanguage == 0
                                ? widget.cartItem.product.title
                                : widget.cartItem.product.titleEngilsh,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                      ),
                      Text(widget.cartItem.productPrice,
                          style: TextStyle(
                              fontSize: 19,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      Row(
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
                                    color: widget.cartItem.productColor,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
                                  widget.cartItem.productSize,
                                  style: TextStyle(fontSize: 13),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FadeInImage(
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  height: 150,
                  width: 150,
                  image: NetworkImage(
                      "${AllProviders.hostName}/images/products/${widget.cartItem.product.image}"),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
