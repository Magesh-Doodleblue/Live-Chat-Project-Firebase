// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

import '../user1/chatbot.dart';
import '../user2/chatbot2.dart';
import 'chatbot3.dart';

class HomePage3 extends StatelessWidget {
  var phoneNumber;

  HomePage3({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Pro")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Hi, $phoneNumber\n    Your Chats",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreens3(),
                  )),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      maxRadius: 23,
                      child: Text("1"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Your Chat",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChatScreens1(), //user 1 chat page with firebase history
                  )),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      maxRadius: 23,
                      child: Text(" 2"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Magesh 1",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChatScreens2(), //user 1 chat page with firebase history
                  )),
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      maxRadius: 23,
                      child: Text(" 3"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Magesh 2",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
