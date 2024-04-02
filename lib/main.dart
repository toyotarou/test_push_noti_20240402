import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'noti_banner_tapped_message.dart';
import 'push_notifications.dart';

//////////////////////////////////////////////
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('◎　Get Background Notification.');
  }
}

//////////////////////////////////////////////

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await PushNotifications.init();
  await PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final payloadData = jsonEncode(message.data);

    print('◎　Get Foreground Notification.');

    if (message.notification != null) {
      PushNotifications.showSimpleNotification(title: message.notification!.title!, body: message.notification!.body!, payload: payloadData);
    }
  });

  runApp(const MyApp());
}

//////////////////////////////////////////////
final navigatorKey = GlobalKey<NavigatorState>();

//////////////////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => const HomePage(),
        '/message': (context) => const NotiBannerTappedMessage(),
      },
    );
  }
}

//////////////////////////////////////////////

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: SafeArea(child: Column(children: [Text('HomePage')])));
}
