import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class FavoriteItemTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
                            "  اسم المنتج اسم المنتج اسم المنتج اسم المنتج   اسم المنتج  ",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).bottomAppBarColor),
                          ),
                        ),
                      ),
                      LikeButton(
                        size: 30,
                        isLiked: true,
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
                Image.asset(
                  "assets/images/product1.jpg",
                  width: 150,
                  height: 150,
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
