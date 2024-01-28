import 'package:device_apps/device_apps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../executables/controllers/apps_controller.dart';
import '../executables/controllers/method_channel_controller.dart';
import 'firebase_options.dart';
import 'local_notification.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print('Message data: ${message.data}');
  Application? app = await DeviceApps.getApp(message.data['packageName'] ?? "");
  Get.find<AppsController>()
      .addToLockedApps(app!, message.data['body'] ?? "Enable");
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    Get.find<AppsController>().getAppsData();
    Get.find<AppsController>().getLockedApps();
    Get.find<MethodChannelController>().addToLockedAppsMethod();
  });

  showNotification(
      message.data['title'] ?? message.notification?.title.toString(),
      message.data['body'] ?? message.notification?.body.toString(),
      message.data['packageName'] ?? "");
}

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setUpNotification() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'flutter.native/helper', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

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
    Get.find<AppsController>()
        .addToLockedApps(app!, message.data['body'] ?? "Enable");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Get.find<AppsController>().getAppsData();
      Get.find<AppsController>().getLockedApps();
      Get.find<MethodChannelController>().addToLockedAppsMethod();
    });

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
  print("Registration Token:$token");
}
