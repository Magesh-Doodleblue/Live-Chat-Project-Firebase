import 'package:flutter/material.dart';
import 'presentation/screens/homepage.dart';
// import 'presentation/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        // home: const Scaffold(body: Login()));
        home: const Scaffold(body: HomePage()));
  }
}
