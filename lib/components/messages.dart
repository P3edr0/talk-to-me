import 'package:flutter/material.dart';
import 'package:talk_to_me/components/message_buble.dart';
import 'package:talk_to_me/core/models/chat_message.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';
import 'package:talk_to_me/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
        stream: ChatService().messagesStream(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Iniciar uma conversa!"),
            );
          } else {
            final msgs = snapshot.data!;
            return ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: ((context, index) => Container(
                    // margin: const EdgeInsets.all(2),
                    // height: 20,
                    //   color: Theme.of(context).primaryColor,
                    child: MessageBuble(
                        key: ValueKey(msgs[index].id),
                        message: msgs[index],
                        belongsToCurrentUser:
                            msgs[index].userId == currentUser?.id),
                  )),
            );
          }
        }));
  }
}
