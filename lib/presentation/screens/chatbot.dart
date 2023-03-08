// ignore_for_file: unused_import, library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/model/chat_messages.dart';
import 'chat_input.dart';
import 'chatbubble.dart';

class ChatScreens extends StatefulWidget {
  const ChatScreens({Key? key}) : super(key: key);

  @override
  _ChatScreensState createState() => _ChatScreensState();
}

class _ChatScreensState extends State<ChatScreens> {
  final List<ChatMessage> _messages = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  initState() {
    print("initState Called");
  }

  Future<String> getResponse(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode(
        {
          'prompt':
              'The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nUser: $message\n',
          'temperature': 0.5,
          'max_tokens': 20,
          'top_p': 1,
          'frequency_penalty': 0,
          'presence_penalty': 0
        },
      ),
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('error')) {
      print(responseBody['error']);
      return 'Sorry, there was an error with the AI chatbot. Please try again later.';
    }

    final completions = responseBody['choices'][0]['text'];
    final textBeforeNewline = completions.split('\n')[0];

    return textBeforeNewline;
  }

  Future<void> _handleSubmitted(String text) async {
    setState(() {
      _messages.add(ChatMessage(message: text, isUserMessage: true));
    });
    final response = await getResponse(text);
    setState(() {
      _messages.add(ChatMessage(message: response, isUserMessage: false));
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


  // void addToDatabase(bool isUserMessage, String message) async {
  //   DocumentReference docRef = _db.collection('Chat_messages').doc('Magesh1');

  //   await docRef.set({
  //     "hi": "bye",
  //     'Message': message,
  //     'isUserMessage': isUserMessage,
  //   });
  // }