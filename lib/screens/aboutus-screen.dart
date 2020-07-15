import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/application.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
    Provider.of<AllProviders>(context, listen: false).NavBarShow(true);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context, listen: false);
    final application =
        Provider.of<ApplicationProvider>(context, listen: false);
    final lang = Provider.of<Languages>(context);

    return WillPopScope(
      onWillPop: () {
        allPro.NavBarShow(true);
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  lang.translation['aboutUs'][Languages.selectedLanguage],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder(
              future: application.fetchDataAboutUs(),
              builder: (ctx, authResultSnap) {
                if (authResultSnap.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
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
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          lang.translation['aboutUs']
                              [Languages.selectedLanguage],
                        ),
                        Divider(
                          endIndent: 100,
                          indent: 100,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            application.aboutus,
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 23,
                                color: Theme.of(context).bottomAppBarColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                lang.translation['socialMedia']
                                    [Languages.selectedLanguage],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                endIndent: 100,
                                indent: 100,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  application.facebook != ''
                                      ? InkWell(
                                          onTap: () async {
                                            final url = application.facebook;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.asset(
                                              "assets/images/facebook.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  application.insta != ''
                                      ? InkWell(
                                          onTap: () async {
                                            final url = application.insta;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.asset(
                                              "assets/images/instagram.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  application.youtube != ''
                                      ? InkWell(
                                          onTap: () async {
                                            final url = application.youtube;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.asset(
                                              "assets/images/youtube.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  application.twitter != ''
                                      ? InkWell(
                                          onTap: () async {
                                            final url = application.twitter;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Image.asset(
                                              "assets/images/twitter.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
