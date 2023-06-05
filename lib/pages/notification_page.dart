import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_me/core/services/notifications/chat_notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
        appBar: AppBar(title: const Text('Minhas Notificações')),
        body: ListView.builder(
            itemCount: service.itemsCount,
            itemBuilder: ((context, index) => ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].body),
                  onTap: () => service.remove(index),
                ))));
  }
}
