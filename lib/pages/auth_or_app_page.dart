import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';
import 'package:talk_to_me/core/services/notifications/chat_notification_service.dart';
import 'package:talk_to_me/pages/auth_page.dart';
import 'package:talk_to_me/pages/chat_page.dart';
import 'package:talk_to_me/pages/loading_page.dart';

class AuthOrAppPage extends StatefulWidget {
  const AuthOrAppPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthOrAppPageState();
}

class _AuthOrAppPageState extends State<AuthOrAppPage> {
  Future<void> init(BuildContext context) async {
    if (!mounted) return;

    await Provider.of<ChatNotificationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return FutureBuilder(
        future: init(context),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }

          return StreamBuilder<ChatUser?>(
              stream: AuthService().userChanges,
              builder: ((context, snapshot) {
                log("Chamou o brabo");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                } else {
                  return snapshot.hasData ? const ChatPage() : const AuthPage();
                }
              }));
        }));
  }
}
