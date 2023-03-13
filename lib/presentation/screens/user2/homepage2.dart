import 'package:flutter/material.dart';

import '../user1/chatbot.dart';
import 'chatbot2.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Pro")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreens2()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Welcome user 2 \n\n     Your Chats\n",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ChatScreens1(), //user 1 chat page with firebase history
                  )),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      maxRadius: 33,
                      child: Text("Chat 1"),
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
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      maxRadius: 33,
                      child: Text("Chat 1"),
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
