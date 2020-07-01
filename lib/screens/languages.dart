import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
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

  bool arabic_selected = true;
  bool english_selected = false;
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);

    return WillPopScope(
      onWillPop: () {
        print("sas");

        allPro.NavBarShow(true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "اللغة",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      arabic_selected = !arabic_selected;
                      english_selected = !english_selected;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: arabic_selected == true
                                  ? Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 5)
                                  : Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 0)),
                          child: Image.asset(
                            "assets/images/iraq.jpg",
                            width: 170,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "اللغة العربية",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      arabic_selected = !arabic_selected;
                      english_selected = !english_selected;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: english_selected == true
                                  ? Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 5)
                                  : Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 0)),
                          child: Image.asset(
                            "assets/images/usa.png",
                            width: 170,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "English Language",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
