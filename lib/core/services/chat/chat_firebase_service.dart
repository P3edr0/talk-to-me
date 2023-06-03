import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talk_to_me/core/models/chat_message.dart';
import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/chat/chat_service.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createAt', descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((e) {
        return e.data();
      }).toList();
    });
// MESMA IMPLEMENTAÇÃO DE CIMA PORÉM MAIS INTUITIVA

    // return Stream<List<ChatMessage>>.multi((controller) {
    //   snapshots.listen((query) {
    //     List<ChatMessage> listMessages = query.docs.map((element) {
    //       return element.data();
    //     }).toList();
    //   });
    // });
  }

  @override
  Future<ChatMessage?> save(String message, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final msg = ChatMessage(
        id: '',
        text: message,
        createAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);
    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final doc = await docRef.get();
    final data = doc.data()!;
    return data;
  }

  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
        id: doc.id,
        text: doc['text'],
        createAt: DateTime.parse(doc['createAt']),
        userId: doc['userId'],
        userName: doc['userName'],
        userImageURL: doc['userImageURL']);
  }

  Map<String, dynamic> _toFirestore(ChatMessage msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createAt': msg.createAt.toString(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageURL': msg.userImageURL,
    };
  }
}
