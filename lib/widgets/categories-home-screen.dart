import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:flutter/material.dart';

class CategoriesHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    //widget.pageController.jumpToPage(2);
                  },
                  child: Row(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0),
                      //   child: Icon(
                      //     Icons.keyboard_arrow_left,
                      //     size: 18,
                      //   ),
                      // ),
                      Text(
                        // lang.translation['MoreTitle']
                        //     [Languages.selectedLanguage],
                        "المزيد",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).bottomAppBarColor,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Text(
                  // lang.translation['accourdingToCategory']
                  //     [Languages.selectedLanguage],
                  "تسوق في",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).bottomAppBarColor,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: GridView.builder(
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.of(context)
                            .bottomAppBarColor
                            .withOpacity(0.2),
                        offset: Offset(2.0, 3.0),
                        blurRadius: 1.4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        EcommerceIcons.wallet,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "category",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        maxLines: 2,
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
