// import 'package:a_alkarar_lab/screens/main-screen.dart';
// import 'package:a_alkarar_lab/screens/news-pressed-screen.dart';
import 'package:ecommerce_template/providers/allProviders.dart';
import 'package:ecommerce_template/providers/application.dart';
import 'package:ecommerce_template/providers/cart.dart';
import 'package:ecommerce_template/providers/dummyData.dart';
import 'package:ecommerce_template/providers/languages.dart';
import 'package:ecommerce_template/providers/ordering.dart';
import 'package:ecommerce_template/providers/settings.dart';
import 'package:ecommerce_template/providers/theme_manager.dart';
import 'package:ecommerce_template/providers/user.dart';
import 'package:ecommerce_template/screens/main-screen.dart';
import 'package:ecommerce_template/screens/pressed-product.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() async {
//Remove this method to stop OneSignal Debugging
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("265e0969-9fdf-4f47-aed6-028a67bb28e9", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 6)
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DummyData(),
        ),
        ChangeNotifierProvider.value(
          value: AllProviders(),
        ),
        ChangeNotifierProxyProvider<AllProviders, CartProvider>(
          update: (context, allProviders, applicationProvider) =>
              CartProvider(allProviders),
          create: (BuildContext context) => CartProvider(null),
        ),
        ChangeNotifierProvider.value(
          value: Languages(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ThemeManager(),
        ),
        ChangeNotifierProvider.value(
          value: Ordering(),
        ),
        ChangeNotifierProvider.value(
          value: SettingsProvider(),
        ),
        ChangeNotifierProxyProvider<AllProviders, ApplicationProvider>(
          update: (context, allProviders, applicationProvider) =>
              ApplicationProvider(allProviders),
          create: (BuildContext context) => ApplicationProvider(null),
        ),
      ],
      child: Phoenix(
        child: Consumer<ThemeManager>(builder: (context, manager, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: manager.themeData,
            color: Colors.redAccent,
            title: 'Ecommerce Creative Projects',
            home: SplashScreen(
              'assets/iraq3d.flr',
              (context) {
                return MainScreen(0);
              },
              // Future.delayed(Duration(milliseconds: 1)),
              startAnimation: 'Untitled',
              //backgroundColor: Colors.white,
              isLoading: true,

              backgroundColor: Color(0xff215a7d),
            ),
            initialRoute: '/',
            routes: {
              MainScreen.routeName: (ctx) => MainScreen(0),
            },
          );
        }),
      ),
    ),
  );
}
