// ignore_for_file: unused_import, library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/model/user3/chat_messages3.dart';
import '../../../domain/chatbot_logic/chatbot_logic.dart';

import '../../widget/user3/chat_input3.dart';
import '../../widget/user3/chatbubble3.dart';

class ChatScreens3 extends StatefulWidget {
  const ChatScreens3({Key? key}) : super(key: key);

  @override
  _ChatScreens3State createState() => _ChatScreens3State();
}

class _ChatScreens3State extends State<ChatScreens3> {
  final List<ChatMessage3> _messages = [];

  // Add a StreamController to listen for updates to the chat history
  final StreamController<List<ChatMessage3>> _streamController =
      StreamController<List<ChatMessage3>>.broadcast();

  @override
  void initState() {
    super.initState();
    // Call the function to retrieve the chat history on initialization
    _getChatHistory();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  // Function to retrieve the chat history
  void _getChatHistory() {
    FirebaseFirestore.instance
        .collection('Magesh3_chat_history')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      final List<ChatMessage3> messages = [];
      for (var doc in snapshot.docs) {
        messages.add(ChatMessage3(
          message: doc['user_message'],
          isUserMessage: true,
        ));
        messages.add(ChatMessage3(
          message: doc['bot_response'],
          isUserMessage: false,
        ));
      }
      // Add the retrieved messages to the stream controller
      _streamController.add(messages);
    });
  }

  Future<void> _handleSubmitted(String text) async {
    setState(() {
      _messages.add(ChatMessage3(message: text, isUserMessage: true));
    });
    final response = await getResponse(text);
    setState(() {
      _messages.add(ChatMessage3(message: response, isUserMessage: false));
    });
    await FirebaseFirestore.instance
        .collection('Magesh3_chat_history')
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
            child: StreamBuilder<List<ChatMessage3>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = snapshot.data![index];
                    return ChatBubble3(
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
                );
              },
            ),
          ),
          ChatInput3(
            onSubmitted: _handleSubmitted,
            messages: _messages,
          ),
        ],
      ),
    );
  }
}
