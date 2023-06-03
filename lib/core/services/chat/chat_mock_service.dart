import 'dart:async';
import 'dart:math';

import 'package:talk_to_me/core/models/chat_message.dart';
import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String message, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: message,
        createAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);

    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
