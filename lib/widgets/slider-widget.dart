import 'package:ecommerce_template/providers/allProviders.dart';
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
                        dotBgColor: Colors.transparent,
                        dotColor: Theme.of(context).primaryColor,
                        dotIncreaseSize: 1.2,
                        autoplayDuration: Duration(milliseconds: 2000),
                        borderRadius: true,
                        images: allposts.sliders.map(
                          (item) {
                            return NetworkImage(
                                "${AllProviders.hostName}/images/sliders/${item.image}");
                          },
                        ).toList(),
                      );
                    }
                  })
              : Carousel(
                  boxFit: BoxFit.cover,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  onImageTap: (index) {
                    print("image index : $index");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PressedProduct(
                            //product: widget.product,
                            isMain: false,
                            productid: 20,
                            pressedWithProductId: true,
                          ),
                        ));
                  },
                  dotIncreaseSize: 1.2,
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
