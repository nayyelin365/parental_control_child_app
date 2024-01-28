import 'package:device_apps/device_apps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../executables/controllers/apps_controller.dart';
import '../services/init.dart';
import 'firebase_options.dart';
import 'local_notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');

  Application? app = await DeviceApps.getApp(message.data['packageName'] ?? "");
  initialize();
  Get.find<AppsController>().addToLockedApps(app!);
}

Future<void> setUpNotification() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //request permission
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  //ios
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  //for foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    Application? app =
        await DeviceApps.getApp(message.data['packageName'] ?? "");
    Get.find<AppsController>().addToLockedApps(app!);

    showNotification(message.data['title'], message.data['body'],
        message.data['packageName'] ?? "");
  });

  //for background (no need)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  getToken();
}

String token = "";

getToken() async {
  token = (await FirebaseMessaging.instance.getToken())!;
  // setState(() {
  //   token = token;
  //   StorageUtils.putString("fcmToken", token.toString());
  // });
  Get.find<AppsController>().saveFirebaseToken(token.toString());
  print("Registration Token:" + token.toString());
}
