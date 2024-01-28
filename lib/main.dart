import 'package:app_lock_flutter/screens/splash.dart';
import 'package:app_lock_flutter/services/init.dart';
import 'package:app_lock_flutter/services/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'executables/controllers/apps_controller.dart';
import 'executables/controllers/home_screen_controller.dart';
import 'executables/controllers/method_channel_controller.dart';
import 'executables/controllers/password_controller.dart';
import 'executables/controllers/permission_controller.dart';
import 'firebase_noti/local_notification.dart';
import 'firebase_noti/notification_api.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    Get.put(() => prefs);
    Get.put(() => AppsController(prefs: Get.find()));
    Get.put(() => HomeScreenController(prefs: Get.find()));
    Get.put(() => MethodChannelController());
    Get.put(() => PermissionController());
    Get.put(() => PasswordController(prefs: Get.find()));

    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");

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
