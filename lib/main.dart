import 'package:app_lock_flutter/screens/splash.dart';
import 'package:app_lock_flutter/services/init.dart';
import 'package:app_lock_flutter/services/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_noti/local_notification.dart';
import 'firebase_noti/notification_api.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  if (!kIsWeb) {
    await setUpNotification();
    await notificationSetup();
    FirebaseMessaging.instance
        .subscribeToTopic("specific_token"); //later to setup for specific child
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.dark,
      home: const SplashPage(),
    );
  }
}
