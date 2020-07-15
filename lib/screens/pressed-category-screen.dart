import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/models/Product-show.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PressedCategoryScreen extends StatefulWidget {
  final Category category;
  final String subCat;
  PressedCategoryScreen({this.category, this.subCat});

  @override
  _PressedCategoryScreenState createState() => _PressedCategoryScreenState();
}

class _PressedCategoryScreenState extends State<PressedCategoryScreen> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.

    setState(() {
      AllProviders.dataOfflineAllProductsCategory = null;
      _selectedChoice = choice;
    });
  }

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
    final allPro = Provider.of<AllProviders>(context);
    return WillPopScope(
      onWillPop: () {
        allPro.NavBarShow(true);
        return Future.value(true);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              title: Text(
                widget.subCat == null
                    ? Languages.selectedLanguage == 0
                        ? "${widget.category.mainCategory}"
                        : "${widget.category.mainCategoryEnglish}"
                    : "${widget.subCat}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 150,
              backgroundColor: Theme.of(context).primaryColor,
              pinned: true,
              actions: <Widget>[
                PopupMenuButton<Choice>(
                  onSelected: _select,
                  icon: Icon(Icons.filter_list),
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(choice.title),
                            Icon(
                              choice.icon,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
              iconTheme: IconThemeData(color: Colors.white),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.category.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    image: NetworkImage(
                        "${AllProviders.hostName}/images/categories/${widget.category.image}"),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(15),
                        child: Text(
                          Languages.selectedLanguage == 0
                              ? "${widget.category.mainCategory}"
                              : "${widget.category.mainCategoryEnglish}",
                          textAlign: Languages.selectedLanguage == 0
                              ?  TextAlign.right : TextAlign.left ,
                          style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).bottomAppBarColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    AllProviders.dataOfflineAllProductsCategory == null
                        ? FutureBuilder(
                            future: allPro.fetchDataAllProductsOnCategory(
                                widget.category.mainCategory,
                                _selectedChoice.title),
                            builder: (ctx, authResultSnap) {
                              if (authResultSnap.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
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
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  //height: MediaQuery.of(context).size.height / 4.1,
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.7 / 1,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                      children: allPro.allProductsCategory
                                          .map((item) {
                                        return ProductMainTemplate(
                                          product: ProductShow(
                                            id: item.id,
                                            title: item.title,
                                            titleEngilsh: item.titleEngilsh,
                                            description: item.description,
                                            descriptionEnglish:
                                                item.descriptionEnglish,
                                            price: item.price,
                                            discount: item.discount,
                                            favorite: item.favorite,
                                            discountPercentage:
                                                item.discountPercentage,
                                            image: item.image,
                                            mainCategory: item.mainCategory,
                                            subCategories: item.subCategories,
                                            isQuestion: item.isQuestion,
                                            date: item.date,
                                            noColor: item.noColor,
                                          ),
                                          isMain: false,
                                        );
                                      }).toList()),
                                );
                              }
                            })
                        : Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            //height: MediaQuery.of(context).size.height / 4.1,
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7 / 1,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                                children:
                                    allPro.allProductsCategory.map((item) {
                                  return ProductMainTemplate(
                                    product: ProductShow(
                                      id: item.id,
                                      title: item.title,
                                      titleEngilsh: item.titleEngilsh,
                                      description: item.description,
                                      descriptionEnglish:
                                          item.descriptionEnglish,
                                      price: item.price,
                                      discount: item.discount,
                                      favorite: item.favorite,
                                      discountPercentage:
                                          item.discountPercentage,
                                      image: item.image,
                                      mainCategory: item.mainCategory,
                                      subCategories: item.subCategories,
                                      isQuestion: item.isQuestion,
                                      date: item.date,
                                      noColor: item.noColor,
                                    ),
                                    isMain: false,
                                  );
                                }).toList()),
                          ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'حسب السعر', icon: EcommerceIcons.percentage),
  const Choice(title: 'حسب تاريخ الاضافة', icon: Icons.date_range),
];
