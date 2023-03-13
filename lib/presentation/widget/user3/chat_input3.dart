// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:chatproject/data/model/user3/chat_messages3.dart';

class ChatInput3 extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final List<ChatMessage3> messages;

  const ChatInput3(
      {super.key, required this.onSubmitted, required this.messages});

  @override
  _ChatInput3State createState() => _ChatInput3State();
}

class _ChatInput3State extends State<ChatInput3> {
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
