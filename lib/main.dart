import 'package:agendize/src/appTheme/appTheme.dart';
import 'package:agendize/src/login/screen/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AgendizeApp());
}

class AgendizeApp extends StatelessWidget {
  const AgendizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      theme: agendizeTheme,
    );
  }
}
