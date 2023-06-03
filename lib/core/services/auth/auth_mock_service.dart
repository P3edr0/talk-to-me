import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:talk_to_me/core/models/chat_user.dart';
import 'package:talk_to_me/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = ChatUser(
      email: "renata@gmail.com",
      id: "1",
      imageURL: "assets/avatar.jpg",
      name: "Renata");
  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
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
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final newUser = ChatUser(
        email: email,
        id: Random().nextDouble().toString(),
        imageURL: image?.path ?? "assets/avatar.jpg",
        name: name);

    print("testadinho");

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) async {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
