import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:reviews_slider/reviews_slider.dart';

class PostPressedScreen extends StatefulWidget {
  static const routeName = '/post_pressed_screen';
  final News postData;
  PostPressedScreen({this.postData});

  @override
  _PostPressedScreenState createState() => _PostPressedScreenState();
}

class _PostPressedScreenState extends State<PostPressedScreen> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    print(widget.postData.date.toString());
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    print("BACK BUTTON!"); // Do some stuff.
    Provider.of<AllProviders>(context, listen: false).NavBarShow(true);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);

    //final postData = ModalRoute.of(context).settings.arguments as Post;

    //final loadedNews = Provider.of<OthersProvider>(context).findById(productId);
    //final List<String> texts = loadedNews.text.split("*");
    //final Widget test = loadedNews.test;
    //print(test);
    //final lang = Provider.of<Languages>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        allPro.NavBarShow(true);
        return Future.value(true);
      },
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
                  tag: widget.postData.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/slider1.png'),
                    height: MediaQuery.of(context).size.height * 0.35,
                    image: NetworkImage(
                        "${AllProviders.hostName}/images/posts/${widget.postData.image}"),
                    fit: BoxFit.cover,
                  ),
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
                                  Languages.selectedLanguage == 0
                                      ? widget.postData.title
                                      : widget.postData.titleEnglish,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'tajawal',
                                      color:
                                           Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.postData.date.toString(),
                                  style: TextStyle(
                                      fontFamily: 'tajawal',
                                      color: Theme.of(context).accentColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          Languages.selectedLanguage == 0
                              ? widget.postData.text
                              : widget.postData.textEnglish,
                          textAlign: TextAlign.justify,
                          textDirection: Languages.selectedLanguage == 0
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontFamily: 'tajawal',
                              fontSize: 20,
                              color:  Colors.blueGrey,
                              height: 1.5),
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
  print("fuck");
  return new Future.value(true);
}
