import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'myapp.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Run the app
  runApp(const MyApp());
}
