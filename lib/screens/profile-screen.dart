import 'package:badges/badges.dart';
import 'package:ecommerce_template/app_themes.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/theme_manager.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/screens/aboutus-screen.dart';
import 'package:ecommerce_template/screens/favorite-screen.dart';
import 'package:ecommerce_template/screens/languages.dart';
import 'package:ecommerce_template/screens/login-screen.dart';
import 'package:ecommerce_template/screens/order-history-screen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ecommerce_icons_icons.dart';

class ProfileScreen extends StatefulWidget {
  final PersistentTabController controller;

  ProfileScreen({this.controller});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

bool notification = false;
bool darkTheme = false;
int preferredTheme;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) {
      preferredTheme = prefs.getInt("theme_preference") ?? 0;
      if (preferredTheme == 0) {
        darkTheme = false;
      } else {
        darkTheme = true;
      }
    });

    super.initState();
  }

  //int notinumber;
  @override
  Widget build(BuildContext context) {
    final allPro = Provider.of<AllProviders>(context);
    final userPro = Provider.of<UserProvider>(context);
    final cartPro = Provider.of<CartProvider>(context);

    cartPro.getNumCartItem();
    
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              UserProvider.isLogin == true
                  ? Container(
                      margin: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: SizedBox(),
                            ),
                            flex: 0,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      UserProvider.userName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .bottomAppBarColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flex: 3,
                          ),
                          Expanded(
                            child: Icon(
                              EcommerceIcons.user,
                              color: Theme.of(context).bottomAppBarColor,
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              UserProvider.isLogin == false
                  ? SettingTemplate(
                      icon: Icons.account_box,
                      title: "تسجيل الدخول",
                      lastWidget: Icon(
                        Icons.keyboard_arrow_left,
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      notiNumber: 0,
                      onTap: () {
                        setState(() {
                          allPro.NavBarShow(false);
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                    )
                  : SizedBox(),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
              ),
              UserProvider.isLogin == true
                  ? SettingTemplate(
                      title: "تسجيل الخروج",
                      lastWidget: Icon(
                        Icons.keyboard_arrow_left,
                        color: Theme.of(context).bottomAppBarColor,
                      ),
                      icon: null,
                      notiNumber: 0,
                      onTap: () {
                        userPro.signOutEmail(widget.controller);
                      },
                    )
                  : SizedBox(),
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
                onTap: () {
                  setState(() {
                    allPro.NavBarShow(false);
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
                      ));
                },
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.favorite,
                notiNumber: allPro.numOfFavorite,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
              ),
              SettingTemplate(
                title: "الطلبات",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: EcommerceIcons.shopping_cart,
                notiNumber: cartPro.cartItemNumber != null
                    ? cartPro.cartItemNumber
                    : 0,
                onTap: () {
                  setState(() {
                    allPro.NavBarShow(false);
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryScreen(),
                      ));
                },
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
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
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
              ),
              SettingTemplate(
                title: "اللغات",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.language,
                notiNumber: 0,
                onTap: () {
                  setState(() {
                    allPro.NavBarShow(false);
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguagesScreen(),
                      ));
                },
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
              ),
              SettingTemplate(
                title: "الوضع الليلي",
                lastWidget: Switch.adaptive(
                  value: darkTheme,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    AppTheme theme;
                    if (value == true) {
                      theme = AppTheme.values[1];
                    } else {
                      theme = AppTheme.values[0];
                    }
                    setState(() {
                      darkTheme = value;
                      Provider.of<ThemeManager>(context, listen: false)
                          .setTheme(theme);
                    });
                  },
                ),
                icon: Icons.brightness_2,
                notiNumber: 0,
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
              ),
              SettingTemplate(
                title: "من نحن",
                lastWidget: Icon(
                  Icons.keyboard_arrow_left,
                  color: Theme.of(context).bottomAppBarColor,
                ),
                icon: Icons.info_outline,
                notiNumber: 0,
                onTap: () {
                  setState(() {
                    allPro.NavBarShow(false);
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUsScreen(),
                      ));
                },
              ),
              Divider(
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).bottomAppBarColor.withOpacity(0.3),
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
                            color: Theme.of(context).bottomAppBarColor),
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
