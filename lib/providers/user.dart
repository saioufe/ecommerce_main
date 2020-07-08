import 'dart:convert';
import 'package:ecommerce_template/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'allProviders.dart';

class UserProvider with ChangeNotifier {
  static bool isLogin = false;
  static String userName;
  static int userId;

  List<UserModel> _user = [];
  List<UserModel> get user {
    return _user;
  }

  List userData = [];
  List<UserModel> loadedUser = [];
  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
    BuildContext contextExit,
    Function snackBar,
    AllProviders allprov2,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post("${AllProviders.hostName}/insert-user.php", body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((respon) {
      //userData = respon.body;
      userData = json.decode(respon.body);
      if (userData[0][0] == "wrong") {
        isLogin = false;
        snackBar("هذا الحساب موجود مسبقا");
        //showInSnackBar("هذا الحساب موجود مسبقا", context);
        print("هذا الحساب موجود مسبقا");
      } else if (userData[0][0] == "right") {
        //showInSnackBar("تم التسجيل بنجاح", context);
        print("تم التسجيل بنجاح");
        allprov2.NavBarShow(true);
        Navigator.of(contextExit).pop();
        loadedUser.add(UserModel(
          id: userData[0][1],
          name: name,
          email: email,
          password: password,
          phone: phone,
        ));
        prefs.setString('name', name);
        prefs.setInt('id', userData[0][1]);
        prefs.setString('email', email);
        prefs.setString('password', password);
        prefs.setString('phone', phone);
        userName = name;
        userId = userData[0][1];
        print(userId);
        prefs.setString('username', name);
        isLogin = true;
        _user = loadedUser;
        //pageController.jumpToPage(3);
        print(loadedUser[0].name);
        notifyListeners();
      } else {
        //showInSnackBar("حدث خطا يرجى المحاولة لاحقا", context);
        print("حدث خطا يرجى المحاولة لاحقا");
      }
    });
  }

  List userData2 = [];
  Future<void> login(
    String email,
    String password,
    BuildContext contextExit,
    Function snackBar,
    AllProviders allprov2,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post("${AllProviders.hostName}/login-user.php", body: {
      "email": email,
      "password": password,
    }).then((respon) {
      userData2 = json.decode(respon.body);

      if (userData2[0] == "wrong") {
        isLogin = false;
        snackBar("يرجى ادخال المعلومات صحيحة");
      } else {
        userData2.forEach((item) {
          loadedUser.add(UserModel(
            id: int.parse(item['id']),
            name: item['name'],
            email: item['email'],
            password: item['password'],
            phone: item['phone'],
          ));
          prefs.setInt('id',int.parse(item['id']));
          prefs.setString('name', item['name']);
          prefs.setString('email', item['email']);
          prefs.setString('password', item['password']);
          prefs.setString('phone', item['phone']);
          userName = item['name'];
          userId = int.parse(item['id']);
          prefs.setString('username', item['name']);
        });

        isLogin = true;
        print("this is the user id : $userId");
        _user = loadedUser;
        notifyListeners();
        allprov2.NavBarShow(true);
        Navigator.of(contextExit).pop();
      }
    });
  }

  signOutEmail(PersistentTabController pageController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("phone");
    isLogin = false;
    //showInSnackBar("تم تسجيل الخروج", context);
    pageController.jumpToTab(4);
  }

  bool once = false;
  checkLogin() async {
    if (once == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //prefs.clear();
      if (prefs.containsKey('email') && prefs.containsKey("password")) {
        isLogin = true;
        loadedUser = [
          UserModel(
            id: prefs.getInt("id"),
            name: prefs.getString("name"),
            email: prefs.getString("email"),
            password: prefs.getString("password"),
            phone: prefs.getString("phone"),
          )
        ];
        userName = prefs.getString("name");
        userId = prefs.getInt("id");
        _user = loadedUser;
        // fetchUserFiles(loadedPatient[0].id);
        //print("he is online");
        once = true;
      }
    }
  }
}
