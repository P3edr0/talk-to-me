import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_me/components/messages.dart';
import 'package:talk_to_me/components/new_message.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';
import 'package:talk_to_me/core/services/notifications/chat_notification_service.dart';
import 'package:talk_to_me/pages/notification_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color),
                items: [
                  DropdownMenuItem(
                      value: "logout",
                      child: Container(
                        child: Row(
                          children: const [
                            Icon(Icons.exit_to_app),
                            SizedBox(width: 10),
                            Text("Sair")
                          ],
                        ),
                      ))
                ],
                onChanged: (value) async {
                  if (value == "logout") {
                    await AuthService().logout();
                  }
                }),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: (() => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: ((context) => const NotificationPage())))),
                  icon: const Icon(Icons.notifications)),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red.shade800,
                  maxRadius: 10,
                  child: Text(
                      '${Provider.of<ChatNotificationService>(context).itemsCount}',
                      style: const TextStyle(fontSize: 12)),
                ),
              ),
            ],
          )
        ],
        title: const Text("Talk to Me"),
      ),
      body: SafeArea(
        child: Column(
          children: const [Expanded(child: Messages()), NewMessage()],
        ),
      ),
    );
  }
}
