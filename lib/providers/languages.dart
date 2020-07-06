import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends ChangeNotifier {
  List<int> langClicked = [1, 0];

  Map<String, List<String>> translation = {
    'language': [
      'اللغة العربية',
      'ENGLISH',
    ],
    'fastsearch': [
      'البحث السريع',
      'search',
    ],
    'stayhome': [
      'خلك بامان ... خلك بلبيت',
      'stay safe ... stay home',
    ],
    'checkInternet': [
      'يرجى الاتصال بلانترنت',
      'Please check your internet connection',
    ],
    'LastOffers': [
      'اخر العروض',
      'Offers',
    ],
    'accourdingToCategory': [
      'تسوق حسب الفئات',
      'Start with category',
    ],
    'settingsTitle': [
      'الاعدادات',
      'Settings',
    ],
    'notificationTitle': [
      'الاشعارات',
      'Notification',
    ],
    'notificationActivate': [
      'تفعيل الاشعارات',
      'Notification status',
    ],
    'notificationStatusActive': [
      'مفعل',
      'Active',
    ],
    'notificationStatusInactive': [
      'متوقف',
      'inactive',
    ],
    'myaccount': [
      'حسابي',
      'Account',
    ],
    'news': [
      'الاخبار',
      'News',
    ],
    'category': [
      'الفئات',
      'Categories',
    ],
      'orderpage': [
      'ابدا الطلب',
      'start order',
    ],
    'homeTitle': [
      'الرئيسية',
      'Home',
    ],
    'signout': [
      'تسجيل الخروج',
      'Sign out',
    ],
    'myorders': [
      'طلباتي',
      'My orders',
    ],
    'GeneralSetTitle': [
      'عام',
      'General',
    ],
    'LanguageTitle': [
      'اختر اللغة',
      'Choose Language',
    ],
    'startInsuranceNow': [
      ' !!! اطلب تامينك الان',
      'Start your insurance now !!',
    ],
    'startService': [
      'ابدء الخدمة',
      'Start Service',
    ],
    'MoreTitle': [
      'المزيد',
      'More',
    ],
    'appRating': [
      'تقييم التطبيق',
      'Rate The App',
    ],
    'appVersion': [
      'اصدار التطبيق',
      'App Version',
    ],
    'policies': [
      'الشروط والاحكام',
      'Privacy policy',
    ],
    'commonQuestions': [
      'الاسئلة الشائعة',
      'FAQ',
    ],
    'contactuss': [
      'الاتصال بنا',
      'Contact us',
    ],
    'mytameen': [
      'ماي تاميين',
      'My Tameen',
    ],
    'servicesTitle': [
      'الخدمات للفئة',
      'Category services',
    ],

  };
  static int selectedLanguage = 0;
  Future<void> setLangClicker() async {
    for (var i = 0; i < langClicked.length; i++) {
      langClicked[i] = 0;
    }
    notifyListeners();
  }

  readLanguageIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'language';
    final string = prefs.getInt(key);
    if (string == null) {
      selectedLanguage = 0;
    } else {
      selectedLanguage = (prefs.getInt(key));
    }
    notifyListeners();
  }

  static readLanguageIndex2() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'language';
    final string = prefs.getInt(key);
    if (string == null) {
      Languages.selectedLanguage = 0;
    } else {
      Languages.selectedLanguage = (prefs.getInt(key));
    }
  }

  saveLanguageIndex(int languageIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'language';
    var value = languageIndex;
    prefs.setInt(key, value);
    selectedLanguage = languageIndex;
    notifyListeners();
  }
}
