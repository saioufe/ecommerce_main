import 'package:ecommerce_template/Templates/news-home-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:ecommerce_template/widgets/categories-home-screen.dart';
import 'package:ecommerce_template/Templates/category-home-template.dart';
import 'package:ecommerce_template/Templates/product-history-template.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/widgets/slider-widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sizeBetweenWidgets = 20;
    final dummyData = Provider.of<DummyData>(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: sizeBetweenWidgets,
          ),
          SafeArea(
            child: SliderWidget(),
          ),
          SizedBox(
            height: sizeBetweenWidgets,
          ),
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          // if (Languages.selectedLanguage == 0) {
                          //   pageController.jumpToPage(2);
                          // } else {
                          //   pageController.jumpToPage(1);
                          // }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_left,
                              size: 18,
                            ),
                            Text(
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
                        "تسوق حسب الفئات",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).bottomAppBarColor,
                            fontSize: 20),
                      ),
                    ]),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.6,
                //margin: EdgeInsets.only(right: 10, left: 10),
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: dummyData.categories.length,
                    itemBuilder: (ctx, index) {
                      return CategoryHomeTemplate(
                          category: dummyData.categories[index]);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          // if (Languages.selectedLanguage == 0) {
                          //   pageController.jumpToPage(2);
                          // } else {
                          //   pageController.jumpToPage(1);
                          // }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_left,
                              size: 18,
                            ),
                            Text(
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
                        "مشاهدات سابقة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).bottomAppBarColor,
                            fontSize: 20),
                      ),
                    ]),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.6,
                //margin: EdgeInsets.only(right: 10, left: 10),
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: dummyData.products.length,
                    itemBuilder: (ctx, index) {
                      return ProductHistoryTemplate(
                          product: dummyData.products[index]);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_left,
                              size: 18,
                            ),
                            Text(
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
                        "اخر الاخبار",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).bottomAppBarColor,
                            fontSize: 20),
                      ),
                    ]),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25, top: 25),
                color: Colors.white,
                child: Column(
                    children: dummyData.news.map((item) {
                  return NewsHomeTemplate(
                    news: News(
                      id: item.id,
                      title: item.title,
                      desc: item.desc,
                      image: item.image,
                    ),
                  );
                }).toList()),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "شاهد المزيد",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).bottomAppBarColor,
                            fontSize: 20),
                      ),
                    ]),
              ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    //height: MediaQuery.of(context).size.height / 1.1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 1 / 1.6,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: dummyData.products.length,
                      itemBuilder: (context, index) {
                        return ProductMainTemplate(
                            product: dummyData.products[index]);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          //CategoriesHomeScreen(),
          SizedBox(
            height: sizeBetweenWidgets,
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
