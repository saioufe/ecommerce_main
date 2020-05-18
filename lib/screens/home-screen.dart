import 'package:ecommerce_template/widgets/categories-home-screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          "الرئيسية",
          style: TextStyle(fontFamily: "tajawal"),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  left: 10,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 1.1,
                            spreadRadius: 1.0,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "ابدا في البحث",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CategoriesHomeScreen(),
            SizedBox(
              height: 900,
            )
          ],
        ),
      ),
    );
  }
}
