import 'package:flutter/cupertino.dart';

class ChatUser {
  final String id;
  final String name;
  final String email;
  final String imageURL;

  const ChatUser(
      {Key? key,
      required this.email,
      required this.id,
      required this.imageURL,
      required this.name});
}
