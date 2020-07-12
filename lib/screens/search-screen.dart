import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/Templates/searched-word-history.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ecommerce_icons_icons.dart';

class SearchScreen extends StatefulWidget {
  final String searchInitial;

  SearchScreen({this.searchInitial});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<ApplicationProvider>(context, listen: true);
    // appProvider.sharePrefsContaine("search");
    appProvider.searchResult();
    return SafeArea(
      child: SingleChildScrollView(
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
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              width: MediaQuery.of(context).size.width / 1.1,
              child: TextField(
                controller: myController,
                onSubmitted: (value) {
                  appProvider.search(value, context);
                },
                onChanged: (value) {
                  if (value == "") {
                    appProvider.search(value, context);
                  }
                },
                textAlign: TextAlign.right,
                style: TextStyle(color: Theme.of(context).bottomAppBarColor,),
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ابحث عن الاف المنتجات بضغطة زر',
                    hintStyle: TextStyle(
                      color: Theme.of(context).bottomAppBarColor,
                    ),
                    labelStyle: TextStyle(fontSize: 23),
                    prefixIcon: Icon(
                      EcommerceIcons.magnifying_glass,
                      color: Theme.of(context).bottomAppBarColor,
                      size: 20,
                    ),
                    
                    suffixStyle:
                        TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            appProvider.searchProducts.length != 0
                ? Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    //height: MediaQuery.of(context).size.height / 4.1,
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7 / 1,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        children: appProvider.searchProducts.map((item) {
                          return ProductMainTemplate(
                            product: ProductShow(
                                id: item.id,
                                title: item.title,
                                titleEngilsh: item.titleEngilsh,
                                description: item.description,
                                descriptionEnglish: item.descriptionEnglish,
                                price: item.price,
                                discount: item.discount,
                                favorite: item.favorite,
                                discountPercentage: item.discountPercentage,
                                image: item.image,
                                mainCategory: item.mainCategory,
                                subCategories: item.subCategories,
                                isQuestion: item.isQuestion),
                            isMain: false,
                          );
                        }).toList()),
                  )
                : appProvider.oldSearchResult.length > 0
                    ? Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              margin: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        appProvider.deleteSearch();
                                      });
                                    },
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
                                      color:
                                          Theme.of(context).bottomAppBarColor,
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
                                  color: Theme.of(context)
                                      .bottomAppBarColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                child: Column(
                                  children: appProvider.oldSearchResult
                                      .sublist(
                                          0, appProvider.oldSearchResult.length)
                                      .map((item) {
                                    return SearchedWorldHistory(
                                      text: item,
                                      controller: myController,
                                      context: context,
                                    );
                                  }).toList(),
                                ))
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                size: 80,
                                color: Theme.of(context)
                                    .bottomAppBarColor
                                    .withOpacity(0.2),
                              ),
                              Text(
                                "لم تبحث عن اي منتج الى حد هذه اللحظة لنبدا الان  - سوف نساعدك.",
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .bottomAppBarColor
                                      .withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
