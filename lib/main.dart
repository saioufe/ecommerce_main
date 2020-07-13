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
//import 'package:onesignal_flutter/onesignal_flutter.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:provider/provider.dart';
// import './providers/allProvider.dart';
// import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() async {
//Remove this method to stop OneSignal Debugging
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init("0ae33daf-adcb-40b4-a128-f7a3fa6b2ea9", iOSSettings: {
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
      child: Consumer<ThemeManager>(builder: (context, manager, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: manager.themeData,
            title: 'Ecommerce Creative Projects',
            home: MainScreen(0));
        // SplashScreen.navigate(
        //   name: 'assets/images/hairderLab.flr',
        //   next: (_) => MainScreen(0),
        //   until: () => Future.delayed(Duration(seconds: 1)),
        //   startAnimation: 'Untitled',
        //   backgroundColor: Colors.white,
        //   endAnimation: '1',
        // ),
      }),
    ),
  );
}
