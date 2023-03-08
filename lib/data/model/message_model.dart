import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final bool isUserMessage;
  final Timestamp timestamp;

  Message({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
  });

  // convert Message to Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isUserMessage': isUserMessage,
      'timestamp': timestamp,
    };
  }

  // convert Map to Message
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'],
      isUserMessage: map['isUserMessage'],
      timestamp: map['timestamp'],
    );
  }
}
