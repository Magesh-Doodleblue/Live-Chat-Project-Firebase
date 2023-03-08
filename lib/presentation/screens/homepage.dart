import 'package:flutter/material.dart';

import 'git_chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chatting App")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Chatting",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
              },
              child: const Text("GO to chat page"),
            ),
          ],
        ),
      )),
    );
  }
}
