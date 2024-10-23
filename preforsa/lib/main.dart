import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:preforsa/screens/lineas/preforma_ips/screen_preforma_ips.dart';
import 'package:preforsa/screens/lineas/screen_pantalla_inicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Screen_principal(), // Pantalla principal
    );
  }
}
