import 'package:ecommerce_template/models/Product.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
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
  final Product product;
  final bool isMain;
  PressedProduct({this.product, @required this.isMain});

  @override
  _PressedProductState createState() => _PressedProductState();
}

List<String> pics = [
  'https://ae01.alicdn.com/kf/H7b76671f35dd43b5bbd659c5ab6633f1J.jpg?width=750&height=1237&hash=1987',
  'https://ae01.alicdn.com/kf/H9ade6066e8ba4627a28c2ad92815dd02f.jpg?width=750&height=1588&hash=2338',
  'https://ae01.alicdn.com/kf/Ha9c01d1f33f241a4864007384e0e308cp.jpg?width=750&height=839&hash=1589',
];
int currentIndex = 0;

Future<bool> requestPop() {
  print("saif");
  return new Future.value(true);
}

class _PressedProductState extends State<PressedProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
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

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    final allPro = Provider.of<AllProviders>(context);
    //final loadedNews = Provider.of<OthersProvider>(context).findById(productId);
    //final List<String> texts = loadedNews.text.split("*");
    //final Widget test = loadedNews.test;
    //print(test);
    //final lang = Provider.of<Languages>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        print("sas");
        if (widget.isMain == false) {
          allPro.NavBarShow(true);
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
                  child: ExtendedImageGesturePageView.builder(
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
                              "اضف الى سلة التسوق",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      showInSnackBar("تم اضافة المنتج الى سلة المشتريات");
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "منتجات مشابهة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                SimilarItems(),
                SizedBox(
                  height: 25,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
