import 'package:e_belediyecilik/firebase_options.dart';

import 'package:e_belediyecilik/screens/google_maps_marker_pages/map_page.dart';
import 'package:e_belediyecilik/screens/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Belediyecilik Uygulaması',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
