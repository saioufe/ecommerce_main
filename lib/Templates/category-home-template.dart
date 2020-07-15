import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/screens/pressed-category-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryHomeTemplate extends StatefulWidget {
  final Category category;
  CategoryHomeTemplate({this.category});

  @override
  _CategoryHomeTemplateState createState() => _CategoryHomeTemplateState();
}

class _CategoryHomeTemplateState extends State<CategoryHomeTemplate> {
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);

    return InkWell(
      onTap: () {
        setState(() {
          allPro.NavBarShow(false);
        });
        AllProviders.dataOfflineAllProductsCategory = null;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PressedCategoryScreen(category: widget.category)));
      },
      child: ClipRRect(
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
                child: Opacity(
                  opacity: 0.3,
                  child: Hero(
                    tag: widget.category.id,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      height: 190,
                      width: 250,
                      image: NetworkImage(
                          "${AllProviders.hostName}/images/categories/${widget.category.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 80,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    child: Text(
                      Languages.selectedLanguage == 0
                          ? widget.category.mainCategory
                          : widget.category.mainCategoryEnglish,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
