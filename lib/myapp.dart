// import 'package:chatproject/presentation/screens/user3/homepage3.dart';
import 'package:flutter/material.dart';

// import 'presentation/screens/user1/homepage1.dart';

import 'presentation/screens/login_screen.dart';

// import 'presentation/screens/user1/homepage1.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            buttonTheme: const ButtonThemeData(buttonColor: Colors.black)),
        home: const Scaffold(body: Login()));
    // home: const Scaffold(body: HomePage1()));
  }
}
