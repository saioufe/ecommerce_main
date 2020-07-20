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
import 'package:provider/provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class PressedProduct extends StatefulWidget {
  static const routeName = '/pressed-product';
  final ProductShow product;
  final bool pressedWithProductId;
  final int productid;
  final bool isMain;
  PressedProduct(
      {this.product,
      @required this.isMain,
      this.pressedWithProductId,
      this.productid});

  @override
  _PressedProductState createState() => _PressedProductState();
}

List<String> pics = [];
List<ProductQuestion> questions = [];
int currentIndex = 0;
int imageIndex = 1;
bool isLoading = false;
Future<bool> requestPop() {
  print("saif");
  return new Future.value(true);
}

class _PressedProductState extends State<PressedProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
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
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
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
      allPro.fetchDataProductImages(widget.product.id).then((value) {
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
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              pinned: false,
              iconTheme: IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                background: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductImageViewer(
                            pics: pics,
                            product: widget.product,
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
                          setState(() {
                            imageIndex = index + 1;
                          });

                          //    rebuild.add(index);
                        },
                        controller: PageController(
                          initialPage: currentIndex,
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: Text(
                            "$imageIndex / ${pics.length}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //  Image.asset(
                //   "assets/images/${widget.product.images}",
                //   fit: BoxFit.cover,
                // ),
                // FadeInImage(
                //   placeholder: AssetImage('assets/images/slider1.png'),
                //   height: MediaQuery.of(context).size.height * 0.35,
                //   image: NetworkImage(
                //       "${AllProvider.hostName}/images/posts/${postData.postImage}"),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 15,
                ),
                ProductDetailsPressed(
                  product: widget.product,
                ),
                ProductColorSizePressed(
                  product: widget.product,
                ),
                ProductInfoPressed(
                  product: widget.product,
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
                              isLoading == false
                                  ? Text(
                                      lang.translation['addToCart']
                                          [Languages.selectedLanguage],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.white),
                                    )
                                  : CircularProgressIndicator(
                                      backgroundColor: Colors.white,
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

                                    if (AllProviders.selectedPrice != '' &&
                                            AllProviders.selectedSize != '' ||
                                        widget.product.noColor == "1") {
                                      String thePrice;
                                      if (int.tryParse(
                                          AllProviders.selectedPrice) is int) {
                                        thePrice =
                                            "0.${AllProviders.selectedPrice}";
                                      } else {
                                        thePrice = AllProviders.selectedPrice;
                                      }

                                      String theDiscount;
                                      if (int.tryParse(
                                                  AllProviders.selectedDiscount)
                                              is int &&
                                          AllProviders.selectedDiscount != '') {
                                        theDiscount =
                                            "0.${AllProviders.selectedDiscount}";
                                        print("integer");
                                      } else if (AllProviders
                                              .selectedDiscount !=
                                          '') {
                                        theDiscount = double.parse(
                                                AllProviders.selectedDiscount)
                                            .toStringAsFixed(3);
                                        print("double");
                                      }

                                      // print(AllProviders.selectedPrice);
                                      setState(() {
                                        isLoading = true;
                                      });

                                      allCart
                                          .addItemToCart(
                                        widget.product,
                                        thePrice,
                                        theDiscount,
                                        AllProviders.selectedSize,
                                        AllProviders.selectedColor,
                                        AllProviders.selectedQuintity2,
                                      )
                                          .then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        if (value != "0") {
                                          allCart.loadedAllCartItems = null;
                                          allCart.incressCartItemsBadgeNumber();
                                          showInSnackBar(lang.translation[
                                                  'haveBeenAddedToCart']
                                              [Languages.selectedLanguage]);
                                        } else {
                                          showInSnackBar(
                                            lang.translation['alreadyinTheCart']
                                                [Languages.selectedLanguage],
                                          );
                                        }
                                      });
                                    } else {
                                      showInSnackBar(
                                        lang.translation['PleaseSelectColor']
                                            [Languages.selectedLanguage],
                                      );
                                    }
                                  } else {
                                    showInSnackBarForSignIn(
                                      lang.translation['PleaseSignInFirst']
                                          [Languages.selectedLanguage],
                                    );
                                  }
                                }
                              : null
                          : () {
                              if (UserProvider.isLogin == true) {
                                print("price : ${AllProviders.selectedPrice}");
                                print(
                                    "discount : ${AllProviders.selectedDiscount}");
                                print("size : ${AllProviders.selectedSize}");
                                print(
                                    "size : ${AllProviders.selectedQuintity2}");

                                if (AllProviders.selectedPrice != '' &&
                                        AllProviders.selectedSize != '' ||
                                    widget.product.noColor == "1") {
                                  String thePrice;
                                  if (int.tryParse(AllProviders.selectedPrice)
                                      is int) {
                                    thePrice =
                                        "0.${AllProviders.selectedPrice}";
                                  } else {
                                    thePrice = AllProviders.selectedPrice;
                                  }

                                  String theDiscount;
                                  if (int.tryParse(
                                              AllProviders.selectedDiscount)
                                          is int &&
                                      AllProviders.selectedDiscount != '') {
                                    theDiscount =
                                        "0.${AllProviders.selectedDiscount}";
                                    print("integer");
                                  } else if (AllProviders.selectedDiscount !=
                                      '') {
                                    theDiscount = double.parse(
                                            AllProviders.selectedDiscount)
                                        .toStringAsFixed(3);
                                    print("double");
                                  }

                                  // print(AllProviders.selectedPrice);
                                  allCart
                                      .addItemToCart(
                                    widget.product,
                                    thePrice,
                                    theDiscount,
                                    AllProviders.selectedSize,
                                    AllProviders.selectedColor,
                                    AllProviders.selectedQuintity2,
                                  )
                                      .then((value) {
                                    if (value != "0") {
                                      allCart.loadedAllCartItems = null;
                                      allCart.incressCartItemsBadgeNumber();
                                      showInSnackBar(lang.translation[
                                              'haveBeenAddedToCart']
                                          [Languages.selectedLanguage]);
                                    } else {
                                      showInSnackBar(
                                        lang.translation['alreadyinTheCart']
                                            [Languages.selectedLanguage],
                                      );
                                    }
                                  });
                                } else {
                                  showInSnackBar(
                                    lang.translation['PleaseSelectColor']
                                        [Languages.selectedLanguage],
                                  );
                                }
                              } else {
                                showInSnackBar(
                                  lang.translation['PleaseSignInFirst']
                                      [Languages.selectedLanguage],
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
                SimilarItems(widget.product),
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
}
