import 'package:talk_to_me/core/models/chat_message.dart';
import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String message, ChatUser user);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
