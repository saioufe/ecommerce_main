import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/languages.dart';
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
    final lang = Provider.of<Languages>(context);
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
              margin: EdgeInsets.only(top: 20, right: 20),
              child: Text(
                lang.translation['LanguageTitle'][Languages.selectedLanguage],
                style: TextStyle(
                  fontSize: 23,
                  //fontWeight: FontWeight.w600,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    lang.saveLanguageIndex(0);
                    Languages.selectedLanguage = 0;
                    lang.saveLanguageIndex(0);
                    //setState(() {});
                    //Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: Languages.selectedLanguage == 0
                        ? EdgeInsets.only(right: 15)
                        : EdgeInsets.only(left: 15),
                    alignment: Languages.selectedLanguage == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      "اللغة العربية",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).bottomAppBarColor),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    lang.saveLanguageIndex(1);
                    Languages.selectedLanguage = 1;
                    lang.saveLanguageIndex(1);
                  },
                  child: Container(
                    alignment: Languages.selectedLanguage == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    margin: Languages.selectedLanguage == 0
                        ? EdgeInsets.only(right: 15)
                        : EdgeInsets.only(left: 15),
                    child: Text(
                      "English Language",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).bottomAppBarColor),
                    ),
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
