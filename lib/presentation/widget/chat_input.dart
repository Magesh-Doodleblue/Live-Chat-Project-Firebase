// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../data/model/chat_messages.dart';

class ChatInput extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final List<ChatMessage> messages;

  const ChatInput(
      {super.key, required this.onSubmitted, required this.messages});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
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
