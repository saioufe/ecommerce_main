import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../ecommerce_icons_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

bool notification = false;
bool darkTheme = false;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "الاعدادات",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SettingTemplate(
                title: "تسجيل الدخول",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: EcommerceIcons.user,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "تسجيل الخروج",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: null,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "تعديل الحساب",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: null,
                notiNumber: 0,
              ),
              Container(
                margin: EdgeInsets.only(right: 25, top: 15, bottom: 15),
                alignment: Alignment.centerRight,
                child: Text(
                  "الحساب",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ),
              SettingTemplate(
                title: "المفضلات",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.favorite,
                notiNumber: 2,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "الطلبات",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: EcommerceIcons.shopping_cart,
                notiNumber: 6,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              Container(
                margin: EdgeInsets.only(right: 25, top: 15, bottom: 15),
                alignment: Alignment.centerRight,
                child: Text(
                  "اعدادات عامة",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).bottomAppBarColor,
                  ),
                ),
              ),
              SettingTemplate(
                title: "الاشعارات",
                lastWidget: Switch.adaptive(
                  value: notification,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    setState(() {
                      notification = value;
                    });
                  },
                ),
                icon: Icons.notifications,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "اللغات",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.language,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "الوضع الليلي",
                lastWidget: Switch.adaptive(
                  value: darkTheme,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    setState(() {
                      darkTheme = value;
                    });
                  },
                ),
                icon: Icons.wb_sunny,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SettingTemplate(
                title: "من نحن",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.info_outline,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingTemplate extends StatelessWidget {
  final String title;
  final int notiNumber;
  final IconData icon;
  final Widget lastWidget;
  final Function onTap;

  SettingTemplate({
    this.title,
    this.notiNumber,
    this.icon,
    this.lastWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: lastWidget,
              ),
              flex: 0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  notiNumber != 0
                      ? Badge(
                          shape: BadgeShape.circle,
                          animationType: BadgeAnimationType.slide,
                          badgeColor: Theme.of(context).primaryColor,
                          animationDuration: Duration(milliseconds: 100),
                          badgeContent: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                notiNumber.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              )),
                        )
                      : SizedBox(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              flex: 3,
            ),
            Expanded(
              child: Icon(
                icon,
                color: Theme.of(context).bottomAppBarColor,
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
