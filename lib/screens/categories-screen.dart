import 'package:ecommerce_template/Templates/category-1-template.dart';
import 'package:ecommerce_template/models/Category.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/providers/settings.dart';
import 'package:ecommerce_template/screens/pressed-category-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  SolidController controller = SolidController();

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);
    final setPro = Provider.of<SettingsProvider>(context);
    //final dummyData = Provider.of<DummyData>(context,listen: false);

    return Scaffold(
      bottomSheet: SolidBottomSheet(
        controller: controller,
        maxHeight: 300,
        canUserSwipe: true,
        headerBar: InkWell(
          onTap: () {
            controller.hide();
          },
          child: Container(
              color: Theme.of(context).primaryColor,
              height: 50,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Consumer<DummyData>(builder: (context, dummy, _) {
                      return Text(
                        setPro.categories[setPro.selectedCat].mainCategory,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    }),
                  ],
                ),
              )),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 56),
          child: Consumer<DummyData>(
            builder: (context, dummy, _) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: setPro
                        .categories[setPro.selectedCat].subCategories
                        .map((item) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            allPro.NavBarShow(false);
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PressedCategoryScreen(
                                  category:
                                      setPro.categories[setPro.selectedCat],
                                  subCat: item,
                                ),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0.4,
                                  blurRadius: 4,
                                  offset: Offset(0, 1)),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                //alignment: Alignment.centerRight,
                child: Text(
                  "الفئات",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ),
              Consumer<DummyData>(
                builder: (context, dummy, _) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    //height: MediaQuery.of(context).size.height / 1.1,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1 / 1.6,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: setPro.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // setState(() {
                            //   selectedCategory = index;
                            // });
                            setPro.setCat(index);
                            if (setPro.categories[setPro.selectedCat]
                                .subCategories.isEmpty) {
                              setState(() {
                                allPro.NavBarShow(false);
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PressedCategoryScreen(
                                        category: setPro
                                            .categories[setPro.selectedCat]),
                                  ));
                            } else {
                              controller.show();
                            }
                          },
                          child: CategoryFirstTemplate(
                            category: setPro.categories[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
    );
  }
}
