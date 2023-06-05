import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_me/core/services/notifications/chat_notification_service.dart';
import 'package:talk_to_me/firebase_options.dart';
import 'package:talk_to_me/pages/auth_or_app_page.dart';

void main() async {
  FirebaseMessaging.onBackgroundMessage((message) async {
    log("_messaging onBackgroundMessage: $message");
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNotificationService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Talk To Me',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const AuthOrAppPage(),
      ),
    );
  }
}
