import 'package:ecommerce_template/Templates/category-1-template.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dummyData = Provider.of<DummyData>(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top :25, bottom: 20),
              width: MediaQuery.of(context).size.width/1.1,
              //alignment: Alignment.centerRight,
              child: Text(
                "الفئات",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
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
                itemCount: dummyData.categories.length,
                itemBuilder: (context, index) {
                  return CategoryFirstTemplate(
                    category: dummyData.categories[index],
                  );
                },
              ),
            ),
            SizedBox(height: 90,)
          ],
        ),
      ),
    );
  }
}
