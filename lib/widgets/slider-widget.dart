import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    final allposts = Provider.of<AllProviders>(context, listen: false);
    final lang = Provider.of<Languages>(context);

    allposts.fetchDataOneProducts();

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        child: SizedBox(
          height: 150.0,
          width: MediaQuery.of(context).size.width / 1.1,
          child: allposts.dataOfflineSlider == null
              ? FutureBuilder(
                  future: allposts.fetchDataSliders(),
                  builder: (ctx, authResultSnap) {
                    if (authResultSnap.connectionState ==
                        ConnectionState.waiting) {
                      return Carousel(
                          boxFit: BoxFit.cover,
                          dotBgColor: Colors.transparent,
                          dotColor: Theme.of(context).primaryColor,
                          dotIncreaseSize: 1.2,
                          autoplayDuration: Duration(milliseconds: 2000),
                          images: [
                            Image.asset(
                              'assets/images/placeholder.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitHeight,
                            ),
                            Image.asset(
                              'assets/images/placeholder.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitHeight,
                            ),
                          ]);
                    } else if (authResultSnap.hasError) {
                      Center(
                        child: Text("تفقد من الاتصال بلانترنت"),
                      );
                      return RaisedButton(
                        onPressed: () {
                          setState(() {
                            //other.getUserLocation();
                          });
                          print(authResultSnap.error.toString());
                        },
                        child: Text("تفقد من الاتصال بلانترنت",
                            style: TextStyle(color: Colors.black)),
                      );
                    } else {
                      return Carousel(
                        boxFit: BoxFit.cover,
                        showIndicator: true,
                        dotIncreasedColor: Theme.of(context).primaryColor,
                        autoplay: true,
                        dotSize: 10,
                        dotHorizontalPadding: 10,
                        // dotBgColor: Colors.transparent,
                        dotColor: Colors.white,
                        onImageTap: (index) {
                          if (allposts.dataOfflineAllProductsOne != null) {
                            print("image index : $index");

                            if (allposts.listOfSlidersId
                                .contains(allposts.sliders[index].productid)) {
                              print("contains");

                              int productIndex = allposts.allProductsOne
                                  .indexWhere((element) =>
                                      element.id ==
                                      allposts.sliders[index].productid);
                              print(productIndex);
                              setState(() {
                                allposts.NavBarShow(false);
                              });
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PressedProduct(
                                    product:
                                        allposts.allProductsOne[productIndex],
                                    isMain: false,
                                  ),
                                ),
                                ModalRoute.withName('/'),
                              );
                            }
                          } else {
                            print("not containes");
                          }
                        },
                        dotIncreaseSize: 1.4,
                        borderRadius: true,
                        autoplayDuration: Duration(milliseconds: 2000),
                        images: allposts.sliders.map((item) {
                          return NetworkImage(
                              "${AllProviders.hostName}/images/sliders/${item.image}");
                        }).toList(),
                      );
                    }
                  })
              : Carousel(
                  boxFit: BoxFit.cover,
                  dotBgColor: Colors.transparent,
                  showIndicator: true,
                  dotIncreasedColor: Theme.of(context).primaryColor,
                  autoplay: true,
                  dotSize: 10,
                  dotHorizontalPadding: 10,
                  dotColor: Colors.white,
                  onImageTap: (index) {
                    if (allposts.dataOfflineAllProductsOne != null) {
                      print("image index : $index");

                      if (allposts.listOfSlidersId
                          .contains(allposts.sliders[index].productid)) {
                        print("contains");

                        int productIndex = allposts.allProductsOne.indexWhere(
                            (element) =>
                                element.id ==
                                allposts.sliders[index].productid);
                        print(productIndex);
                        setState(() {
                          allposts.NavBarShow(false);
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PressedProduct(
                              product: allposts.allProductsOne[productIndex],
                              isMain: false,
                            ),
                          ),
                          ModalRoute.withName('/'),
                        );
                      }
                    } else {
                      print("not containes");
                    }
                  },
                  dotIncreaseSize: 1.4,
                  borderRadius: true,
                  autoplayDuration: Duration(milliseconds: 2000),
                  images: allposts.sliders.map((item) {
                    return NetworkImage(
                        "${AllProviders.hostName}/images/sliders/${item.image}");
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
