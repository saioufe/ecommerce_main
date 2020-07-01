import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/screens/pressed-category-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ecommerce_icons_icons.dart';

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
                    child: Image.asset(
                      "assets/images/${widget.category.image}",
                      height: 150,
                      //color: Colors.grey,
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
                      widget.category.name,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
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
