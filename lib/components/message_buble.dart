import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talk_to_me/core/models/chat_message.dart';

class MessageBuble extends StatelessWidget {
  static const _defaultImage = 'assets/avatar.jpg';
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessageBuble(
      {super.key, required this.message, required this.belongsToCurrentUser});

  Widget _showImageUser(String imageUrl) {
    ImageProvider? provider;

    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(uri.toString());
    } else if (uri.scheme.contains("http")) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(backgroundImage: provider);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.only(
                  left: belongsToCurrentUser ? 20 : 10,
                  right: belongsToCurrentUser ? 10 : 20,
                  top: 30,
                ),
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: belongsToCurrentUser
                            ? const Radius.circular(12)
                            : const Radius.circular(0),
                        bottomRight: belongsToCurrentUser
                            ? const Radius.circular(0)
                            : const Radius.circular(12)),
                    color: belongsToCurrentUser
                        ? Colors.grey.shade300
                        : Theme.of(context).primaryColor),
                child: Column(
                  crossAxisAlignment: belongsToCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.userName,
                      style: TextStyle(
                          color: belongsToCurrentUser
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(message.text,
                        style: TextStyle(
                          color: belongsToCurrentUser
                              ? Colors.black
                              : Colors.white,
                        )),
                  ],
                )),
          ],
        ),
        Positioned(
            top: 20,
            left: belongsToCurrentUser ? null : 165,
            right: belongsToCurrentUser ? 165 : null,
            child: _showImageUser(message.userImageURL)),
      ],
    );
  }
}
