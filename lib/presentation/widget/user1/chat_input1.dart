// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../data/model/user1/chat_messages1.dart';

class ChatInput1 extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final List<ChatMessage1> messages;

  const ChatInput1(
      {super.key, required this.onSubmitted, required this.messages});

  @override
  _ChatInput1State createState() => _ChatInput1State();
}

class _ChatInput1State extends State<ChatInput1> {
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
