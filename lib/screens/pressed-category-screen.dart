import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/Templates/product-main-template.dart';
import 'package:ecommerce_template/ecommerce_icons_icons.dart';
import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
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
    print(choice.title);
    setState(() {
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

    final dummyData = Provider.of<DummyData>(context);

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
                    ? "${widget.category.name}"
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
                    child: Image.asset(
                      "assets/images/${widget.category.image}",
                      fit: BoxFit.cover,
                    )
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
                Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.vertical,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(15),
                        child: Text(
                          "${widget.category.name}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 28,
                              color: Theme.of(context).bottomAppBarColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height / 1.1,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 1 / 1.6,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: dummyData.products.length,
                        itemBuilder: (context, index) {
                          return ProductMainTemplate(
                            product: dummyData.products[index],
                            isMain: true,
                          );
                        },
                      ),
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
