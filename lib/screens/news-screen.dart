import 'package:ecommerce_template/Templates/news-home-template.dart';
import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<Languages>(context, listen: false);

    final allposts = Provider.of<AllProviders>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: Languages.selectedLanguage == 0
                    ? <Widget>[
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              lang.translation['latestNews']
                                  [Languages.selectedLanguage],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).bottomAppBarColor,
                                  fontSize: 28),
                            ),
                          ),
                        ),
                      ]
                    : <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              lang.translation['latestNews']
                                  [Languages.selectedLanguage],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).bottomAppBarColor,
                                  fontSize: 28),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                      ]),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: allposts.newsDataOffline == null
                          ? FutureBuilder(
                              future: allposts.fetchData(),
                              builder: (ctx, authResultSnap) {
                                if (authResultSnap.connectionState ==
                                    ConnectionState.waiting) {
                                  return Shimmer.fromColors(
                                    baseColor: Color(0xFFebeff2),
                                    highlightColor:
                                        Colors.grey.withOpacity(0.2),
                                    period: Duration(milliseconds: 300),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 335,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).canvasColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 335,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).canvasColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32))),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (authResultSnap.hasError) {
                                  print(authResultSnap.error);
                                  return RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        //other.getUserLocation();
                                      });
                                    },
                                    child: Text(
                                        lang.translation['checkInternet']
                                            [Languages.selectedLanguage],
                                        style: TextStyle(color: Colors.black)),
                                  );
                                } else {
                                  return Column(
                                      children: allposts.posts.map((item) {
                                    return PostsHomeTemplate(
                                      news: News(
                                        id: item.id,
                                        title: item.title,
                                        text: item.text,
                                        titleEnglish: item.titleEnglish,
                                        textEnglish: item.textEnglish,
                                        image: item.image,
                                        date: item.date,
                                      ),
                                    );
                                  }).toList());
                                }
                              })
                          : Column(
                              children: allposts.posts.map((item) {
                              return PostsHomeTemplate(
                                news: News(
                                  id: item.id,
                                  title: item.title,
                                  text: item.text,
                                  titleEnglish: item.titleEnglish,
                                  textEnglish: item.textEnglish,
                                  image: item.image,
                                  date: item.date,
                                ),
                              );
                            }).toList()),
                    ),
                  ),

                  Divider(),

                  //  : NewsTemplate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
