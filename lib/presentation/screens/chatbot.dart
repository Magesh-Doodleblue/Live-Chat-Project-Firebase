// ignore_for_file: unused_import, library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/model/chat_messages.dart';
import '../../domain/chatbot_logic/chatbot_logic.dart';
import '../widget/chat_input.dart';
import '../widget/chatbubble.dart';

class ChatScreens extends StatefulWidget {
  const ChatScreens({Key? key}) : super(key: key);

  @override
  _ChatScreensState createState() => _ChatScreensState();
}

class _ChatScreensState extends State<ChatScreens> {
  final List<ChatMessage> _messages = [];

  Future<void> _handleSubmitted(String text) async {
    setState(() {
      _messages.add(ChatMessage(message: text, isUserMessage: true));
    });
    final response = await getResponse(text);
    setState(() {
      _messages.add(ChatMessage(message: response, isUserMessage: false));
    });
    await FirebaseFirestore.instance
        .collection('Magesh1_chat_history')
        .doc()
        .set({
      'user_message': text,
      'bot_response': response,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                // print(message.isUserMessage);
                return ChatBubble(
                  message: message.message,
                  isUserMessage: message.isUserMessage,
                  backgroundColor: message.isUserMessage
                      ? const Color.fromARGB(255, 244, 215, 173)
                      : Colors.black,
                  textColor: message.isUserMessage
                      ? const Color.fromARGB(255, 11, 11, 11)
                      : Colors.white,
                );
              },
            ),
          ),
          ChatInput(
            onSubmitted: _handleSubmitted,
            messages: _messages,
          ),
        ],
      ),
    );
  }
}
