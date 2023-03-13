import 'package:flutter/material.dart';
import 'chatbot.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Pro")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Your Chats",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreens1(),
                  )),
              child: Container(
                height: 70,
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
                      child: Text(" 1"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Your Chat",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
