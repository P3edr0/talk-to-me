import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;

    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user == null) {
      log('Falhou');
      return;
    }
//Upload foto do usuário
    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);
//Atualizar os atributos do usuário
    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageUrl);
//Salvar usuário no banco de dados
    _currentUser = _toChatUser(credential.user!, imageUrl, name);
    await _saveChatuser(_currentUser!);
  }

  static ChatUser _toChatUser(User user, [String? imageURL, String? name]) {
    return ChatUser(
        email: user.email!,
        id: user.uid,
        imageURL: imageURL ?? user.photoURL ?? 'assets/avatar.jpg',
        name: name ?? user.displayName ?? user.email!.split('@')[0]);
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatuser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('user').doc(user.id);
    await docRef.set(
        {'name': user.name, 'email': user.email, 'imageURL': user.imageURL});
  }
}
