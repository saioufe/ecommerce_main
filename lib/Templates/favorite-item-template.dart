import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class FavoriteItemTemplate extends StatefulWidget {
  final ProductShow product;
  FavoriteItemTemplate({this.product});

  @override
  _FavoriteItemTemplateState createState() => _FavoriteItemTemplateState();
}

class _FavoriteItemTemplateState extends State<FavoriteItemTemplate> {
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context, listen: false);

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          allPro.setFavoriteProduct(widget.product, isLiked);
        });
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
                isMain: false,
              ),
            ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        clipBehavior: Clip.antiAlias,
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
                        Expanded(
                          child: Container(
                            width: 120,
                            child: Text(
                              Languages.selectedLanguage == 0
                                  ? widget.product.title
                                  : widget.product.titleEngilsh,
                              textAlign: TextAlign.center,
                              textDirection: Languages.selectedLanguage == 0
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,),
                            ),
                          ),
                        ),
                        LikeButton(
                          size: 30,
                          isLiked: allPro.favoriteList[widget.product.id],
                          onTap: onLikeButtonTapped,
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
                              size: 40,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  FadeInImage(
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    height: 120,
                    width: 200,
                    image: NetworkImage(
                        "${AllProviders.hostName}/images/products/${widget.product.image}"),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
