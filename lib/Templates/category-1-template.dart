import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryFirstTemplate extends StatelessWidget {
  final Category category;
  CategoryFirstTemplate({this.category});
  @override
  Widget build(BuildContext context) {
    final setPro = Provider.of<SettingsProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                  spreadRadius: 0.2)
            ]),
        child: Stack(
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/placeholder.png'),
                image: NetworkImage(
                    "${AllProviders.hostName}/images/categories/${category.image}"),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child:
                            setPro.categories[0].mainCategoriesStyle == "type1"
                                ? Text(
                                    Languages.selectedLanguage == 0
                                        ? "${category.mainCategory}"
                                        : "${category.mainCategoryEnglish}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    Languages.selectedLanguage == 0
                                        ? "${category.mainCategory}"
                                        : "${category.mainCategoryEnglish}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold),
                                  )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
