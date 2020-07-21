import 'package:connectivity/connectivity.dart';
import 'package:ecommerce_template/Templates/news-home-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/settings.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/screens/news-screen.dart';
import 'package:ecommerce_template/screens/posts-pressed-screen.dart';
import 'package:ecommerce_template/screens/pressed-product-notification.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:ecommerce_template/widgets/categories-home-screen.dart';
import 'package:ecommerce_template/Templates/category-home-template.dart';
import 'package:ecommerce_template/Templates/product-history-template.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/widgets/slider-widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  final PersistentTabController controller;

  HomeScreen({this.controller});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

ScrollController controller = ScrollController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000), () {
      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        // a notification has been opened
        if (result.notification.payload.additionalData['id'] != '') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PressedProductNotification(
                  controller: widget.controller,
                  id: result.notification.payload.additionalData['id'],
                  isMain: true,
                ),
              ));
        }

        print('this is ${result.notification.payload.additionalData['id']}');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allposts = Provider.of<AllProviders>(context, listen: false);
    final cartPro = Provider.of<CartProvider>(context, listen: false);
    final setPro = Provider.of<SettingsProvider>(context, listen: false);
    final lang = Provider.of<Languages>(context);

    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels == 0) {
        } else {
          setState(() {
            if (allposts.allProducts.length >
                allposts.theNumberOfShowsIntheMain) {
              allposts.theNumberOfShowsIntheMain += 1;
            }
          });
        }
      }
    });
    Provider.of<UserProvider>(context, listen: false).checkLogin();
    double sizeBetweenWidgets = 20;

    Future.delayed(const Duration(milliseconds: 700), () async {
      if (lang.onceChangeMain == false) {
        lang.onceChangeMain = true;
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile) {
          // I am connected to a mobile network.
          setState(() {
            Languages.selectedLanguage == 0
                ? widget.controller.jumpToTab(4)
                : widget.controller.jumpToTab(0);
          });
        } else if (connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a wifi network.
          setState(() {
            Languages.selectedLanguage == 0
                ? widget.controller.jumpToTab(4)
                : widget.controller.jumpToTab(0);
          });
        } else {
          // I am not connected to anything
          showDialog(
            context: context,
            barrierDismissible: false,
            child: AlertDialog(
              actions: <Widget>[
                RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    lang.onceChangeMain = false;
                    setPro.dataOfflineAllCategories = null;
                    setPro.fetchDataCategories();
                    Phoenix.rebirth(context);
                  },
                  child: Text(
                    lang.translation['noInternetConeectionRetryButton']
                        [Languages.selectedLanguage],
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
              content: Text(
                lang.translation['noInternetConeection']
                    [Languages.selectedLanguage],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35),
              ),
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.warning,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                  ],
                ),
              ),
              elevation: 2,
            ),
          );
        }
      }
    });

    return SingleChildScrollView(
      controller: controller,
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
              setPro.dataOfflineAllCategories == null
                  ? FutureBuilder(
                      future: setPro.fetchDataCategories(),
                      builder: (ctx, authResultSnap) {
                        if (authResultSnap.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (authResultSnap.hasError) {
                          Center(
                            child: Text(
                              lang.translation['checkInternet']
                                  [Languages.selectedLanguage],
                            ),
                          );
                          return RaisedButton(
                            onPressed: () {
                              setState(() {
                                //other.getUserLocation();
                              });
                              print(authResultSnap.error.toString());
                            },
                            child: Text(
                                lang.translation['checkInternet']
                                    [Languages.selectedLanguage],
                                style: TextStyle(color: Colors.black)),
                          );
                        } else {
                          print(setPro.categories.length);
                          if (setPro.categories.isEmpty != true &&
                              setPro.categories[0].showCategories == "1") {
                            return Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: Languages.selectedLanguage == 0
                                        ? <Widget>[
                                            InkWell(
                                              onTap: () {
                                                widget.controller.jumpToTab(3);
                                                // if (Languages.selectedLanguage == 0) {
                                                //   pageController.jumpToPage(2);
                                                // } else {
                                                //   pageController.jumpToPage(1);
                                                // }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.keyboard_arrow_left,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    lang.translation[
                                                            'moreTitle'][
                                                        Languages
                                                            .selectedLanguage],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .bottomAppBarColor,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              lang.translation[
                                                      'shopInCategories']
                                                  [Languages.selectedLanguage],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .bottomAppBarColor,
                                                  fontSize: 20),
                                            ),
                                          ]
                                        : <Widget>[
                                            Text(
                                              lang.translation[
                                                      'shopInCategories']
                                                  [Languages.selectedLanguage],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .bottomAppBarColor,
                                                  fontSize: 20),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                widget.controller.jumpToTab(1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 18,
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor,
                                                  ),
                                                  Text(
                                                    lang.translation[
                                                            'moreTitle'][
                                                        Languages
                                                            .selectedLanguage],
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .bottomAppBarColor,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                  ),
                                ),
                                SizedBox(
                                  height: sizeBetweenWidgets,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height:
                                      MediaQuery.of(context).size.height / 5.6,
                                  //margin: EdgeInsets.only(right: 10, left: 10),
                                  child: Center(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: setPro.categories[0]
                                                    .homeCategoriesStyle ==
                                                "type1"
                                            ? 2
                                            : 1,
                                        childAspectRatio: 0.5 / 0.9,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 15,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: setPro.categories.length,
                                      itemBuilder: (ctx, index) {
                                        return CategoryHomeTemplate(
                                            category: setPro.categories[index]);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: sizeBetweenWidgets,
                            );
                          }
                        }
                      })
                  : setPro.categories.isEmpty != true &&
                          setPro.categories[0].showCategories == "1"
                      ? Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: Languages.selectedLanguage == 0
                                    ? <Widget>[
                                        InkWell(
                                          onTap: () {
                                            widget.controller.jumpToTab(3);
                                            // if (Languages.selectedLanguage == 0) {
                                            //   pageController.jumpToPage(2);
                                            // } else {
                                            //   pageController.jumpToPage(1);
                                            // }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                Icons.keyboard_arrow_left,
                                                size: 18,
                                                color: Theme.of(context)
                                                    .bottomAppBarColor,
                                              ),
                                              Text(
                                                lang.translation['moreTitle'][
                                                    Languages.selectedLanguage],
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          lang.translation['shopInCategories']
                                              [Languages.selectedLanguage],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .bottomAppBarColor,
                                              fontSize: 20),
                                        ),
                                      ]
                                    : <Widget>[
                                        Text(
                                          lang.translation['shopInCategories']
                                              [Languages.selectedLanguage],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .bottomAppBarColor,
                                              fontSize: 20),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            widget.controller.jumpToTab(1);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                lang.translation['moreTitle'][
                                                    Languages.selectedLanguage],
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor,
                                                    fontSize: 15),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                              ),
                            ),
                            SizedBox(
                              height: sizeBetweenWidgets,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              height: MediaQuery.of(context).size.height / 5.6,
                              //margin: EdgeInsets.only(right: 10, left: 10),
                              child: Center(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: setPro.categories[0]
                                                .homeCategoriesStyle ==
                                            "type1"
                                        ? 2
                                        : 1,
                                    childAspectRatio: 0.5 / 0.9,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 15,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: setPro.categories.length,
                                  itemBuilder: (ctx, index) {
                                    return CategoryHomeTemplate(
                                        category: setPro.categories[index]);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: sizeBetweenWidgets,
                        ),
              // SizedBox(
              //   height: sizeBetweenWidgets,
              // ),

              // Container(
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   child: Row(
              //       mainAxisAlignment: Languages.selectedLanguage != 0
              //           ? MainAxisAlignment.start
              //           : MainAxisAlignment.end,
              //       children: <Widget>[
              //         InkWell(
              //           onTap: () {
              //             // if (Languages.selectedLanguage == 0) {
              //             //   pageController.jumpToPage(2);
              //             // } else {
              //             //   pageController.jumpToPage(1);
              //             // }
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               // Icon(
              //               //   Icons.keyboard_arrow_left,
              //               //   size: 18,
              //               // ),
              //               // Text(
              //               //   lang.translation['moreTitle']
              //               //       [Languages.selectedLanguage],
              //               //   textAlign: TextAlign.right,
              //               //   style: TextStyle(
              //               //       fontWeight: FontWeight.w500,
              //               //       color: Theme.of(context).bottomAppBarColor,
              //               //       fontSize: 15),
              //               // ),
              //             ],
              //           ),
              //         ),
              //         Text(
              //           lang.translation['historyView']
              //               [Languages.selectedLanguage],
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontWeight: FontWeight.w500,
              //               color: Theme.of(context).bottomAppBarColor,
              //               fontSize: 20),
              //         ),
              //       ]),
              // ),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   height: MediaQuery.of(context).size.height / 4.6,
              //   //margin: EdgeInsets.only(right: 10, left: 10),
              //   child: Center(
              //     child: GridView.builder(
              //       shrinkWrap: true,
              //       reverse: true,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 1,
              //         childAspectRatio: 1 / 1,
              //         crossAxisSpacing: 20,
              //         mainAxisSpacing: 10,
              //       ),
              //       scrollDirection: Axis.horizontal,
              //       itemCount: dummyData.products.length,
              //       itemBuilder: (ctx, index) {
              //         return ProductHistoryTemplate(
              //           product: dummyData.products[index],
              //           isMain: false,
              //         );
              //       },
              //     ),
              //   ),
              // ),

              Container(
                  padding: EdgeInsets.only(bottom: 25, top: 25),
                  color: Colors.white,
                  child: allposts.newsDataOffline == null
                      ? FutureBuilder(
                          future: allposts.fetchData(),
                          builder: (ctx, authResultSnap) {
                            if (authResultSnap.connectionState ==
                                ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                  baseColor: Theme.of(context).primaryColor,
                                  highlightColor: Colors.grey.withOpacity(0.2),
                                  period: Duration(milliseconds: 300),
                                  child: Container(
                                    height: 135,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.11),
                                          blurRadius: 0.1,
                                          spreadRadius:
                                              0.1, // has the effect of extending the shadow
                                          offset: Offset(
                                            0, // horizontal, move right 10
                                            0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            } else if (authResultSnap.hasError) {
                              Center(
                                child: Text(
                                  lang.translation['checkInternet']
                                      [Languages.selectedLanguage],
                                ),
                              );
                              return RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    //other.getUserLocation();
                                  });
                                  print(authResultSnap.error.toString());
                                },
                                child: Text(
                                    lang.translation['checkInternet']
                                        [Languages.selectedLanguage],
                                    style: TextStyle(color: Colors.black)),
                              );
                            } else if (allposts.posts.isEmpty != true) {
                              if (allposts.posts[0].showPosts == "1") {
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: Languages.selectedLanguage ==
                                                0
                                            ? <Widget>[
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_left,
                                                        size: 18,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewsScreen(),
                                                              ));
                                                        },
                                                        child: Text(
                                                          lang.translation[
                                                                  'moreTitle'][
                                                              Languages
                                                                  .selectedLanguage],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  lang.translation['latestNews']
                                                      [Languages
                                                          .selectedLanguage],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ]
                                            : <Widget>[
                                                Text(
                                                  lang.translation['latestNews']
                                                      [Languages
                                                          .selectedLanguage],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewsScreen(),
                                                              ));
                                                        },
                                                        child: Text(
                                                          lang.translation[
                                                                  'moreTitle'][
                                                              Languages
                                                                  .selectedLanguage],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                      ),
                                    ),
                                    Column(
                                        children: allposts.posts
                                            .sublist(
                                                0,
                                                allposts.posts.length > 2
                                                    ? 2
                                                    : 1)
                                            .map((item) {
                                      return PostsHomeTemplate(
                                        news: News(
                                          id: item.id,
                                          title: item.title,
                                          text: item.text,
                                          titleEnglish: item.titleEnglish,
                                          textEnglish: item.textEnglish,
                                          image: item.image,
                                          date: item.date,
                                          showPosts: item.showPosts,
                                        ),
                                        home: true,
                                      );
                                    }).toList()),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                  height: sizeBetweenWidgets,
                                );
                              }
                            }
                          })
                      : allposts.posts.isEmpty != true
                          ? allposts.posts[0].showPosts == "1"
                              ? Column(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: Languages.selectedLanguage ==
                                                0
                                            ? <Widget>[
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_left,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewsScreen(),
                                                              ));
                                                        },
                                                        child: Text(
                                                          lang.translation[
                                                                  'moreTitle'][
                                                              Languages
                                                                  .selectedLanguage],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  lang.translation['latestNews']
                                                      [Languages
                                                          .selectedLanguage],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ]
                                            : <Widget>[
                                                Text(
                                                  lang.translation['latestNews']
                                                      [Languages
                                                          .selectedLanguage],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewsScreen(),
                                                              ));
                                                        },
                                                        child: Text(
                                                          lang.translation[
                                                                  'moreTitle'][
                                                              Languages
                                                                  .selectedLanguage],
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                      ),
                                    ),
                                    Column(
                                        children: allposts.posts
                                            .sublist(
                                                0,
                                                allposts.posts.length > 2
                                                    ? 2
                                                    : 1)
                                            .map((item) {
                                      return PostsHomeTemplate(
                                        news: News(
                                            id: item.id,
                                            title: item.title,
                                            text: item.text,
                                            titleEnglish: item.titleEnglish,
                                            textEnglish: item.textEnglish,
                                            image: item.image,
                                            date: item.date,
                                            showPosts: item.showPosts),
                                        home: true,
                                      );
                                    }).toList()),
                                  ],
                                )
                              : SizedBox(
                                  height: sizeBetweenWidgets,
                                )
                          : SizedBox()),
              SizedBox(
                height: sizeBetweenWidgets,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                    mainAxisAlignment: Languages.selectedLanguage == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lang.translation['discoverMore']
                            [Languages.selectedLanguage],
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
              allposts.dataOfflineAllProducts == null
                  ? FutureBuilder(
                      future: allposts.fetchDataAllProducts(),
                      builder: (ctx, authResultSnap) {
                        if (authResultSnap.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (authResultSnap.hasError) {
                          Center(
                              child: Text(
                            lang.translation['checkInternet']
                                [Languages.selectedLanguage],
                          ));
                          return RaisedButton(
                            onPressed: () {
                              setState(() {
                                //other.getUserLocation();
                              });
                              print(authResultSnap.error.toString());
                            },
                            child: Text(
                                lang.translation['checkInternet']
                                    [Languages.selectedLanguage],
                                style: TextStyle(color: Colors.black)),
                          );
                        } else {
                          return Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            //height: MediaQuery.of(context).size.height / 4.1,
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7 / 1,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                                children: allposts.allProducts
                                    .sublist(
                                        0, allposts.theNumberOfShowsIntheMain)
                                    .map((item) {
                                  return ProductMainTemplate(
                                    product: ProductShow(
                                      id: item.id,
                                      title: item.title,
                                      titleEngilsh: item.titleEngilsh,
                                      description: item.description,
                                      descriptionEnglish:
                                          item.descriptionEnglish,
                                      price: item.price,
                                      discount: item.discount,
                                      favorite: item.favorite,
                                      image: item.image,
                                      mainCategory: item.mainCategory,
                                      subCategories: item.subCategories,
                                      isQuestion: item.isQuestion,
                                      date: item.date,
                                      noColor: item.noColor,
                                    ),
                                    isMain: false,
                                  );
                                }).toList()),
                          );
                        }
                      })
                  : Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      //height: MediaQuery.of(context).size.height / 4.1,
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7 / 1,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          children: allposts.allProducts
                              .sublist(0, allposts.theNumberOfShowsIntheMain)
                              .map((item) {
                            return ProductMainTemplate(
                              product: ProductShow(
                                id: item.id,
                                title: item.title,
                                titleEngilsh: item.titleEngilsh,
                                description: item.description,
                                descriptionEnglish: item.descriptionEnglish,
                                price: item.price,
                                discount: item.discount,
                                discountPercentage: item.discountPercentage,
                                favorite: item.favorite,
                                image: item.image,
                                mainCategory: item.mainCategory,
                                subCategories: item.subCategories,
                                isQuestion: item.isQuestion,
                                date: item.date,
                                noColor: item.noColor,
                              ),
                              isMain: false,
                            );
                          }).toList()),
                    ),
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
