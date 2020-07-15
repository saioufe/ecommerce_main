import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends ChangeNotifier {
  List<int> langClicked = [1, 0];
  bool onceChangeMain = false;
  Map<String, List<String>> translation = {
    'checkInternet': [
      'تفقد من الاتصال بلانترنت',
      'Check your internet connection !',
    ],
    'noInternetConeection': [
      'ليس هنالك اتصال بلانترنت يرجى اعادة المحاولة',
      'No internet connection , Please retry again!',
    ],
    'noInternetConeectionRetryButton': [
      'اعد المحاولة',
      'Retry',
    ],
    'LanguageTitle': [
      'اللغة',
      'Language ',
    ],
    'SettingsTitle': [
      'الاعدادات',
      'Settings ',
    ],
    'signOut': [
      'تسجيل الخروج',
      'Sign out ',
    ],
    'SignIn': [
      'تسجيل الدخول',
      'Sign in ',
    ],
    'accountTitle': [
      'الحساب',
      'Account ',
    ],
    'FavoriteTitle': [
      'المفضلات',
      'Favorite ',
    ],
    'OrdersTitle': [
      'الطلبات',
      'Orders history ',
    ],
    'oldOrdersTitle': [
      'الطلبات السابقة',
      'Last orders',
    ],
    'recentOrdersTitle': [
      'الطلبات الحالية',
      'Recent orders',
    ],
    'MainSettings': [
      'اعدادات عامة',
      'Main',
    ],
    'notification': [
      'الاشعارات',
      'Notification ',
    ],
    'Languages': [
      'اللغات',
      'Languages ',
    ],
    'nightMode': [
      'الوضع الليلي',
      'Night mode ',
    ],
    'aboutUs': [
      'من نحن',
      'About us',
    ],
    'signinTitle': [
      'تسجيل الدخول',
      'Sign up',
    ],
    'registerTitle': [
      'تسجيل',
      'Register',
    ],
    'emailTitle': [
      'البريد الالكتروني',
      'Email',
    ],
    'enterEmail': [
      'ادخل بريدك الالكتروني',
      'Enter your Email',
    ],
    'passwordTitle': [
      'كلمة السر',
      'Password',
    ],
    'passwordTitleEnter': [
      'ادخل كلمة المرور',
      'Enter your password',
    ],
    'phoneTitle': [
      'رقم الهاتف',
      'Phone number',
    ],
    'phoneTitleEnter': [
      'ادخل رقم الهاتف',
      'Enter your phone number',
    ],
    'rememberMe': [
      'تذكرني',
      'Remember me',
    ],
    'DONThaveAccount': [
      'لا تمتلك حساب ؟',
      'Don\'t have account ?',
    ],
    'registerNow': [
      'سجل الان',
      'Register now',
    ],
    'allreadyHaveAccount': [
      'هل لديك حساب بلفعل ؟',
      'Already have account ?',
    ],
    'username': [
      'اسم المستخدم',
      'username',
    ],
    'usernameEnter': [
      'ادخل الاسم الكامل',
      'Enter full name',
    ],
    'pleaseFillAllRecords': [
      'يرجى ملئ جميع الحقول',
      'Please fill all the fields',
    ],
    'pleaseFillEmail': [
      'يرجى ادخال بريد الكتروني صحيح',
      'Please enter a valid email address',
    ],
    'youDidNotAddToCart': [
      'يبدو من انك لم تضف اي منتج لسلة المشتريات , ابدا في التسوق لملئ السلة',
      'Looks like you have\'t add any item yet , let us help you',
    ],
    'startShopping': [
      'ابدا التسوق',
      'Start Shopping',
    ],
    'shoppingBasket': [
      'سلة المشتريات',
      'Shopping basket',
    ],
    'cartTitle': [
      'السلة',
      'Cart',
    ],
    'addressAndPaying': [
      'العنوان والدفع',
      'Address and Payment',
    ],
    'Confirmation': [
      'التاكيد',
      'Confirm',
    ],
    'continue': [
      'المتابعة',
      'Continue',
    ],
    'shippingAddressTitle': [
      'عنوان التوصيل',
      'Shipping Address',
    ],
    'noAddressSelectred': [
      'لم يتم اختيار اي عنوان للتوصيل',
      'No Address have been selected',
    ],
    'EditAddress': [
      'ضبط عنوان السكن',
      'Edit shipping address',
    ],
    'PaymentTitle': [
      'طريقة الدفع',
      'Payment',
    ],
    'payOnDelivered': [
      'دفع عند التوصيل',
      'on delivery',
    ],
    'pleaseSelectValidShippingAddress': [
      'يرجى اختيار عنوان وطريقة دفع صحيحة',
      'Please select valid payment & shipping address',
    ],
    'thersisNoAddressHaveBeenAdded': [
      'ليس هناك اي عنوان مدرج , يرجى اضافة عنوان جديد',
      'No Address have been added , please insert new shipping address',
    ],
    'addNewShippingAddress': [
      'اضافة عنوان جديد',
      'Add new shipping address',
    ],
    'areOrKeyPlease': [
      'المنطقة واي نقطة دالة',
      'Full address',
    ],
    'conutryTitle': [
      'الدولة',
      'Country',
    ],
    'cityTitle': [
      'المدينة',
      'City',
    ],
    'insert': [
      'ادراج',
      'Add',
    ],
    'only3allowed': [
      'يمكن اضافة 3 عناوين فقط',
      'Only 3 addresses allowed',
    ],
    'nameTitle': [
      'الاسم',
      'Name',
    ],
    'addressTitle': [
      'العنوان',
      'Address',
    ],
    'phoneTitleAddress': [
      'الرقم',
      'Phone',
    ],
    'deleteTitle': [
      'حذف',
      'Delete',
    ],
    'chooseTitle': [
      'اختيار',
      'choose',
    ],
    'searchTitle': [
      'البحث',
      'Search',
    ],
    'searchThousndOfProducts': [
      'ابحث عن الاف المنتجات بضغطة زر',
      'Search thousands of products in one click',
    ],
    'searchHistoryTitle': [
      'تاريخ البحث',
      'Search history',
    ],
    'youDidNotSearch': [
      'لم تبحث عن اي منتج الى حد هذه اللحظة لنبدا الان  - سوف نساعدك.',
      'You didn\'t search for any thing yet - let\'s start now we will help you',
    ],
    'noSearchResult': [
      'لا توجد نتائج',
      'No Search Result',
    ],
    'researchAgain': [
      'اعد عملية البحث',
      'Search again please',
    ],
    'categoriesTitle': [
      'الفئات',
      'Categories',
    ],
    'moreTitle': [
      'المزيد',
      'More',
    ],
    'shopInCategories': [
      'تسوق حسب الفئات',
      'Shop in Categories',
    ],
    'historyView': [
      'مشاهدات سابقة',
      'History',
    ],
    'latestNews': [
      'اخر الاخبار',
      'Latest News',
    ],
    'discoverMore': [
      'شاهد المزيد',
      'Discover',
    ],
    'addToCart': [
      'اضف الى سلة التسوق',
      'Add To Cart',
    ],
    'haveBeenAddedToCart': [
      'تم اضافة المنتج الى سلة المشتريات',
      'Product have been added to cart',
    ],
    'alreadyinTheCart': [
      'هذا المنتج موجود مسبقا في السلة',
      'Product already in the cart',
    ],
    'PleaseSelectColor': [
      'يرجى اختيار اللون والحجم',
      'Please select color and size',
    ],
    'PleaseSignInFirst': [
      'يرجى تسجيل الدخول اولا',
      'Please Sign in first',
    ],
    'similarProducts': [
      'منتجات مشابهة',
      'See More',
    ],
    'ColorTitle': [
      ': اللون',
      ': Color',
    ],
    'sizeTitle': [
      ' : الحجم',
      ': Size',
    ],
    'remainsTitle': [
      'متبقي',
      'Remains',
    ],
    'quantityTitle': [
      ' : الكمية',
      ': Quantity',
    ],
    'noFacoriteProducts': [
      'ليس هناك اي منتجات مضافة الى المفضلات',
      'No Favorite product have been selected',
    ],
    'addMoreFavorite': [
      'اضف المزيد',
      'Add more',
    ],
    'clickToSeeMore': [
      'انقر لمشاهدة وصف المنتج',
      'Click to Read more',
    ],
    'DescriptionTitle': [
      ' : الوصف',
      ': Description',
    ],
    'questionAndAnswers': [
      'اسئلة واجوبة مكررة',
      'FAQ',
    ],
    'questionsTitle': [
      ' :  اسئلة',
      ': Questions',
    ],
    'orderDetails': [
      'تفاصيل الطلب',
      'Order History',
    ],
    'orderAddress': [
      'عنوان الطلب',
      'Order History',
    ],
    'orderProducts': [
      'منتجات الطلب',
      'Order Items',
    ],
    'FollowOrder': [
      'تتبع الطلب',
      'Track Order',
    ],
    'moreDetails': [
      'المزيد من التفاصيل',
      'More Details',
    ],
    'socialMedia': [
      'وسائل التواصل',
      'Follow Us',
    ],
    'orderDoneConti': [
      'تمت العملية بنجاح يمكنك متابعة الطلب من الصفحة الشخصية',
      'Order have been made successfully , you can track your order from settings screen',
    ],
    'OK': [
      'حسنا',
      'OK',
    ],
    'ConfirmeDate': [
      'تاكد من المعلومات',
      'Confirme Data',
    ],
    'CantApplyPromo': [
      'لا يمكن تطبيق البروموكود',
      'Can\'t Apply the promocode',
    ],
    'promocodeCorrect': [
      'رمز البروموكود صحيح',
      'promocode have been added',
    ],
    'wrongPromocode': [
      'رمز البروموكود خطا',
      'wrong promocode',
    ],
    'promocode': [
      'بروموكود',
      'Promocode',
    ],
    'price': [
      ' : السعر',
      ': Price',
    ],
    'delivery': [
      ' : التوصيل',
      'Delivery',
    ],
    'discount': [
      ' : الخصم',
      ': Discount',
    ],
    'total': [
      ': المجموع',
      ': Total',
    ],
    'confirmeTheBut': [
      'تاكيد عملية الشراء',
      'Confirme the process',
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
