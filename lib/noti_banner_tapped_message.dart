import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///
class NotiBannerTappedMessage extends StatefulWidget {
  const NotiBannerTappedMessage({super.key});

  @override
  State<NotiBannerTappedMessage> createState() => _NotiBannerTappedMessageState();
}

///
class _NotiBannerTappedMessageState extends State<NotiBannerTappedMessage> {
  Map<String, dynamic> payload = {};

  ///
  @override
  Widget build(BuildContext context) {
//    final notiData = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    final notiData = ModalRoute.of(context)!.settings.arguments;

    if (notiData is RemoteMessage) {
      payload = notiData.data;
    }

    if (notiData is NotificationResponse) {
      payload = jsonDecode(notiData.payload!);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Noti Tapped')),
      body: SafeArea(child: Text(payload.toString())),
    );
  }
}
