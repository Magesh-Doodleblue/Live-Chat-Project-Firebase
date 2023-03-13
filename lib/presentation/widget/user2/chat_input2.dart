// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:chatproject/data/model/user2/chat_messages2.dart';

class ChatInput2 extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final List<ChatMessage2> messages;

  const ChatInput2(
      {super.key, required this.onSubmitted, required this.messages});

  @override
  _ChatInput2State createState() => _ChatInput2State();
}

class _ChatInput2State extends State<ChatInput2> {
  final _textController = TextEditingController();

  void _handleSubmitted(String text) {
    widget.onSubmitted(text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
