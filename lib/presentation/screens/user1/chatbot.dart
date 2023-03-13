// ignore_for_file: unused_import, library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/model/user1/chat_messages1.dart';
import '../../../domain/chatbot_logic/chatbot_logic.dart';

import '../../widget/user1/chat_input1.dart';
import '../../widget/user1/chatbubble1.dart';

class ChatScreens1 extends StatefulWidget {
  const ChatScreens1({Key? key}) : super(key: key);

  @override
  _ChatScreens1State createState() => _ChatScreens1State();
}

class _ChatScreens1State extends State<ChatScreens1> {
  final List<ChatMessage1> _messages = [];

  // Add a StreamController to listen for updates to the chat history
  final StreamController<List<ChatMessage1>> _streamController =
      StreamController<List<ChatMessage1>>.broadcast();
  final ScrollController _scrollController = ScrollController();

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
        .collection('Magesh1_chat_history')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      final List<ChatMessage1> messages = [];
      for (var doc in snapshot.docs) {
        messages.add(ChatMessage1(
          message: doc['user_message'],
          isUserMessage: true,
        ));
        messages.add(ChatMessage1(
          message: doc['bot_response'],
          isUserMessage: false,
        ));
      }
      _streamController.add(messages);
    });
  }

  Future<void> _handleSubmitted(String text) async {
    setState(() {
      _messages.add(ChatMessage1(message: text, isUserMessage: true));
    });
    final response = await getResponse(text);
    setState(() {
      _messages.add(ChatMessage1(message: response, isUserMessage: false));
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
            child: StreamBuilder<List<ChatMessage1>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = snapshot.data![index];
                    return ChatBubble1(
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
          ChatInput1(
            onSubmitted: _handleSubmitted,
            messages: _messages,
          ),
        ],
      ),
    );
  }
}
