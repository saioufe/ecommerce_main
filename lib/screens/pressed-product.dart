import 'package:ecommerce_template/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PressedProduct extends StatefulWidget {
  static const routeName = '/pressed_product_screen';

  @override
  _PressedProductState createState() => _PressedProductState();
}

class _PressedProductState extends State<PressedProduct> {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;

    //final loadedNews = Provider.of<OthersProvider>(context).findById(productId);
    //final List<String> texts = loadedNews.text.split("*");
    //final Widget test = loadedNews.test;
    //print(test);
    //final lang = Provider.of<Languages>(context, listen: false);
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(loadedProduct.title),
        // ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: product.id,
                  child: Image.asset(
                    "assets/images/${product.images}",
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ),
                  // FadeInImage(
                  //   placeholder: AssetImage('assets/images/slider1.png'),
                  //   height: MediaQuery.of(context).size.height * 0.35,
                  //   image: NetworkImage(
                  //       "${AllProvider.hostName}/images/posts/${postData.postImage}"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          spreadRadius:
                              0.8, // has the effect of extending the shadow
                          offset: Offset(
                            0, // horizontal, move right 10
                            0, // vertical, move down 10
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  product.title,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: 'tajawal',
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _requestPop() {
  return new Future.value(true);
}
