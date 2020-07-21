import 'dart:convert';

import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/models/product_question.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/screens/home-screen.dart';
import 'package:ecommerce_template/screens/login-screen.dart';
import 'package:ecommerce_template/screens/product-image-viewer.dart';
import 'package:ecommerce_template/widgets/product-color-size-section.dart';
import 'package:ecommerce_template/widgets/product-details-section.dart';
import 'package:ecommerce_template/widgets/product-info-section.dart';
import 'package:ecommerce_template/widgets/similar-items.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:http/http.dart' as http;

class PressedProductNotification extends StatefulWidget {
  final PersistentTabController controller;

  static const routeName = '/pressed-product';
  final String id;
  final bool pressedWithProductId;
  final int productid;
  final bool isMain;
  PressedProductNotification({
    this.id,
    @required this.isMain,
    this.pressedWithProductId,
    this.productid,
    this.controller,
  });

  @override
  _PressedProductNotificationState createState() =>
      _PressedProductNotificationState();
}

List<String> pics = [];
List<ProductQuestion> questions = [];
int currentIndex = 0;

Future<bool> requestPop() {
  print("saif");
  return new Future.value(true);
}

class _PressedProductNotificationState
    extends State<PressedProductNotification> {
  final GlobalKey<ScaffoldState> _scaffoldKey3 = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    AllProviders.selectedSize = '';
    AllProviders.selectedPrice = '';
    AllProviders.selectedDiscount = '';
    AllProviders.selectedColor = '';
    AllProviders.selectedQuintity2 = 1;
    AllProviders.getOnceImage = false;
    AllProviders.onceNoColor = false;
    AllProviders.getOnceQuestion = false;
    AllProviders.selectedPercentage = 0.0;

    AllProviders.dataOfflineAllProductsSimilar = null;
    if (AllProviders.dataOfflineAllProductsQuestion != null) {
      AllProviders.dataOfflineAllProductsQuestion = null;
    }
    if (AllProviders.dataOfflineAllProductsColors != null) {
      AllProviders.dataOfflineAllProductsColors = null;
    }

    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    if (AllProviders.dataOfflineAllProductsColors != null) {
      AllProviders.dataOfflineAllProductsColors = null;
    }
    print("BACK BUTTON!"); // Do some stuff.
    if (widget.isMain == false) {
      Provider.of<AllProviders>(context, listen: false).NavBarShow(true);
    }

    Navigator.pop(context);
    return true;
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey3.currentState?.removeCurrentSnackBar();
    _scaffoldKey3.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    ));
  }

  void showInSnackBarForSignIn(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey3.currentState?.removeCurrentSnackBar();
    _scaffoldKey3.currentState.showSnackBar(new SnackBar(
      action: UserProvider.isLogin == false
          ? SnackBarAction(
              label: "Sign in",
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    )).then((value) {});
              },
            )
          : SizedBox(),
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context, listen: false);
    final allCart = Provider.of<CartProvider>(context, listen: false);
    final lang = Provider.of<Languages>(context);

    if (AllProviders.getOnceImage != true) {
      if (allPro.allProductsImages != null) {
        allPro.allProductsImages.clear();
        pics.clear();
      }
      allPro.fetchDataProductImages(widget.id).then((value) {
        allPro.allProductsImages.reversed.map((image) {
          pics.add("${AllProviders.hostName}/images/products/${image.image}");
          print(image.image);
        }).toList();
      });
      AllProviders.getOnceImage = true;
    }

    //final loadedNews = Provider.of<OthersProvider>(context).findById(productId);
    //final List<String> texts = loadedNews.text.split("*");
    //final Widget test = loadedNews.test;
    //print(test);
    //final lang = Provider.of<Languages>(context, listen: false);
    return FutureBuilder(
        future: fetchDataAllProductsNotification(widget.id),
        builder: (ctx, authResultSnap) {
          if (authResultSnap.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (authResultSnap.hasError) {
            Center(
                child: Text(
              lang.translation['checkInternet'][Languages.selectedLanguage],
            ));
            return RaisedButton(
              onPressed: () {
                print(authResultSnap.error.toString());
              },
              child: Text(
                  lang.translation['checkInternet'][Languages.selectedLanguage],
                  style: TextStyle(color: Colors.black)),
            );
          } else {
            return WillPopScope(
              onWillPop: () {
                if (widget.isMain == false) {
                  allPro.NavBarShow(true);
                }
                if (AllProviders.dataOfflineAllProductsColors != null) {
                  AllProviders.dataOfflineAllProductsColors = null;
                }
                return Future.value(true);
              },
              child: Scaffold(
                key: _scaffoldKey3,
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: 300,
                      pinned: false,
                      iconTheme:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      flexibleSpace: FlexibleSpaceBar(
                        background: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductImageViewer(
                                    pics: pics,
                                    product: allProducts[0],
                                    currentIndex: currentIndex,
                                  ),
                                ));
                          },
                          child: Stack(
                            children: <Widget>[
                              ExtendedImageGesturePageView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  var item = pics[index];
                                  Widget image = ExtendedImage.network(
                                    item,
                                    enableLoadState: true,
                                    initGestureConfigHandler: (s) {
                                      return GestureConfig(
                                        inPageView: true, initialScale: 1.0,

                                        //you can cache gesture state even though page view page change.
                                        //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                                        cacheGesture: true,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    mode: ExtendedImageMode.gesture,
                                    cache: true,
                                  );
                                  image = Container(
                                    child: image,
                                  );
                                  if (index == currentIndex) {
                                    return Hero(
                                      tag: item + index.toString(),
                                      child: image,
                                    );
                                  } else {
                                    return image;
                                  }
                                },
                                itemCount: pics.length,
                                onPageChanged: (int index) {
                                  currentIndex = index;

                                  //    rebuild.add(index);
                                },
                                controller: PageController(
                                  initialPage: currentIndex,
                                ),
                                scrollDirection: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 15,
                        ),
                        ProductDetailsPressed(
                          product: allProducts[0],
                        ),
                        ProductColorSizePressed(
                          product: allProducts[0],
                        ),
                        ProductInfoPressed(
                          product: allProducts[0],
                        ),
                        Container(
                          child: FlatButton(
                              color: Theme.of(context).primaryColor,
                              disabledColor: Colors.grey,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        lang.translation['addToCart']
                                            [Languages.selectedLanguage],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 23, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              onPressed: allPro.selectedQuantity != ""
                                  ? int.parse(allPro.selectedQuantity) > 0
                                      ? () {
                                          if (UserProvider.isLogin == true) {
                                            print(
                                                "price : ${AllProviders.selectedPrice}");
                                            print(
                                                "discount : ${AllProviders.selectedDiscount}");
                                            print(
                                                "size : ${AllProviders.selectedSize}");
                                            print(
                                                "size : ${AllProviders.selectedQuintity2}");

                                            if (AllProviders.selectedPrice !=
                                                        '' &&
                                                    AllProviders.selectedSize !=
                                                        '' ||
                                                allProducts[0].noColor == "1") {
                                              String thePrice;

                                              thePrice =
                                                  AllProviders.selectedPrice;

                                              String theDiscount;

                                              theDiscount =
                                                  AllProviders.selectedDiscount;

                                              allCart
                                                  .addItemToCart(
                                                allProducts[0],
                                                thePrice,
                                                theDiscount,
                                                AllProviders.selectedSize,
                                                AllProviders.selectedColor,
                                                AllProviders.selectedQuintity2,
                                              )
                                                  .then((value) {
                                                if (value != "0") {
                                                  allCart.loadedAllCartItems =
                                                      null;
                                                  allCart
                                                      .incressCartItemsBadgeNumber();
                                                  showDialog(
                                                    context: context,
                                                    child: AlertDialog(
                                                      actions: <Widget>[
                                                        RaisedButton(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Icon(
                                                            Icons.done,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          onPressed: () {
                                                            Languages.selectedLanguage ==
                                                                    0
                                                                ? widget
                                                                    .controller
                                                                    .jumpToTab(
                                                                        1)
                                                                : widget
                                                                    .controller
                                                                    .jumpToTab(
                                                                        3);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                      content: Text(
                                                        lang.translation[
                                                                'haveBeenAddedToCart']
                                                            [Languages
                                                                .selectedLanguage],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 35),
                                                      ),
                                                      title: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .done_outline,
                                                              color:
                                                                  Colors.green,
                                                              size: 40,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      elevation: 2,
                                                    ),
                                                  );
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    child: AlertDialog(
                                                      content: Text(
                                                        lang.translation[
                                                                'alreadyinTheCart']
                                                            [Languages
                                                                .selectedLanguage],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 35),
                                                      ),
                                                      title: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.warning,
                                                              color: Colors
                                                                  .redAccent,
                                                              size: 40,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      elevation: 2,
                                                    ),
                                                  );
                                                }
                                              });
                                            } else {
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  content: Text(
                                                    lang.translation[
                                                            'PleaseSelectColor']
                                                        [Languages
                                                            .selectedLanguage],
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 35),
                                                  ),
                                                  title: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.warning,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  elevation: 2,
                                                ),
                                              );
                                            }
                                          } else {
                                            showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                content: Text(
                                                  lang.translation[
                                                          'PleaseSignInFirst'][
                                                      Languages
                                                          .selectedLanguage],
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 35),
                                                ),
                                                title: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                      : null
                                  : () {
                                      if (UserProvider.isLogin == true) {
                                        print(
                                            "price : ${AllProviders.selectedPrice}");
                                        print(
                                            "discount : ${AllProviders.selectedDiscount}");
                                        print(
                                            "size : ${AllProviders.selectedSize}");
                                        print(
                                            "size : ${AllProviders.selectedQuintity2}");

                                        if (AllProviders.selectedPrice != '' &&
                                                AllProviders.selectedSize !=
                                                    '' ||
                                            allProducts[0].noColor == "1") {
                                          String thePrice;

                                          thePrice = AllProviders.selectedPrice;

                                          String theDiscount;

                                          theDiscount =
                                              AllProviders.selectedDiscount;

                                          // print(AllProviders.selectedPrice);
                                          allCart
                                              .addItemToCart(
                                            allProducts[0],
                                            thePrice,
                                            theDiscount,
                                            AllProviders.selectedSize,
                                            AllProviders.selectedColor,
                                            AllProviders.selectedQuintity2,
                                          )
                                              .then((value) {
                                            if (value != "0") {
                                              allCart.loadedAllCartItems = null;
                                              allCart
                                                  .incressCartItemsBadgeNumber();
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  actions: <Widget>[
                                                    RaisedButton(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                      onPressed: () {
                                                        Languages.selectedLanguage ==
                                                                0
                                                            ? widget.controller
                                                                .jumpToTab(1)
                                                            : widget.controller
                                                                .jumpToTab(3);
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                  content: Text(
                                                    lang.translation[
                                                            'haveBeenAddedToCart']
                                                        [Languages
                                                            .selectedLanguage],
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 35),
                                                  ),
                                                  title: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.done_outline,
                                                          color: Colors.green,
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  elevation: 2,
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  content: Text(
                                                    lang.translation[
                                                            'alreadyinTheCart'][
                                                        Languages
                                                            .selectedLanguage],
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 35),
                                                  ),
                                                  title: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.warning,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  elevation: 2,
                                                ),
                                              );
                                            }
                                          });
                                        } else {
                                          showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              content: Text(
                                                lang.translation[
                                                        'PleaseSelectColor'][
                                                    Languages.selectedLanguage],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 35),
                                              ),
                                              title: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                      } else {
                                        showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            content: Text(
                                              lang.translation[
                                                      'PleaseSignInFirst']
                                                  [Languages.selectedLanguage],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 35),
                                            ),
                                            title: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                    }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          padding: EdgeInsets.all(15),
                          child: Text(
                            lang.translation['similarProducts']
                                [Languages.selectedLanguage],
                            textAlign: Languages.selectedLanguage == 0
                                ? TextAlign.right
                                : TextAlign.left,
                            style: TextStyle(
                                fontSize: 23,
                                color: Theme.of(context).bottomAppBarColor),
                          ),
                        ),
                        SimilarItems(allProducts[0]),
                        // SizedBox(
                        //   height: 25,
                        // ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

List<ProductShow> _allProducts = [];
List<ProductShow> get allProducts {
  return _allProducts;
}

List dataAllProducts = [];
List<ProductShow> loadedAllProducts;
List<dynamic> dataOfflineAllProducts;
double percentage;
int theNumberOfShowsIntheMain;
bool once = false;
Future<void> fetchDataAllProductsNotification(String id) async {
  if (once == false) {
    once = true;
    final response = await http.post(
        '${AllProviders.hostName}/get-one-product-notification.php',
        body: {
          'productid': id,
        });

    dataAllProducts = json.decode(response.body);
    // print(response.body);
    final List<ProductShow> loadedAllProducts = [];
    if (dataAllProducts == null) {
      return;
    }
    dataOfflineAllProducts = dataAllProducts;
    dataAllProducts.forEach((newsId) {
      if (newsId['discount'] != "0") {
        double first =
            double.parse(newsId['discount']) - double.parse(newsId['price']);
        double second = first / double.parse(newsId['price']);
        percentage = second * 100;
      }
      loadedAllProducts.add(ProductShow(
        id: newsId['id'],
        image: newsId['image'],
        title: newsId['title'],
        titleEngilsh: newsId['titleEnglish'],
        description: newsId['description'],
        descriptionEnglish: newsId['descriptionEnglish'],
        //favorite: productFavoritesIds.contains(newsId['id']) ? true : false,
        mainCategory: newsId['mainCategory'],
        subCategories: newsId['subCategories'].toString().split(","),
        price: newsId['price'],
        discount: newsId['discount'],
        discountPercentage: percentage,
        isQuestion: newsId['isQuestion'],
        date: newsId['date'],
        noColor: newsId['noColor'],
      ));
    });

    if (loadedAllProducts.length > 2) {
      theNumberOfShowsIntheMain = 2;
    } else {
      theNumberOfShowsIntheMain = 1;
    }
    //fetchFavorites();
    _allProducts = loadedAllProducts;
  }

  // notifyListeners();
}
