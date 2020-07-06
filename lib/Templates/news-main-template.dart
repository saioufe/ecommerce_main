import 'package:ecommerce_template/models/News.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/posts-pressed-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allPosts = Provider.of<AllProviders>(context, listen: false);
    return SizedBox(
      //height: MediaQuery.of(context).size.height * 3.55,
      child: Column(
          children: allPosts.posts.map((item) {
        return Template(
          news: News(
            id: item.id,
            title: item.title,
            titleEnglish: item.titleEnglish,
            text: item.text,
            textEnglish: item.textEnglish,
            date: item.date,
            image: item.image,
          ),
        );
      }).toList()),
    );
  }
}

class Template extends StatelessWidget {
  final News news;
  const Template({
    Key key,
    @required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PostPressedScreen.routeName, arguments: news);
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10.0,
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Hero(
                tag: news.id,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  height: MediaQuery.of(context).size.height * 0.35,
                  image: NetworkImage(
                      "${AllProviders.hostName}/images/posts/${news.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     print("clicked");
                  //   },
                  //   child: Icon(Icons.share,
                  //       color: Theme.of(context).bottomAppBarColor),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  Languages.selectedLanguage == 0
                      ? news.title
                      : news.titleEnglish,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'tajawal',
                      fontSize: 20,
                      color: Theme.of(context).bottomAppBarColor,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0, top: 5),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.7,
                child: Center(
                  child: Text(
                    news.date,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'tajawal',
                      color:
                          Theme.of(context).bottomAppBarColor.withOpacity(0.5),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
