import 'package:ad_foot/screens/main_screen_.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ad_foot/screens/splash_screen.dart';
import 'package:ad_foot/controller/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Firebase avec les options de plateforme
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialisation de GetX pour la gestion de l'état global
  Get.put(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ad Foot',
      theme: ThemeData(
        primaryColor: const Color(0xFF214D4F),  // Couleur principale
        scaffoldBackgroundColor: const Color(0xFFE6EEFA),  // Couleur de fond
      ),
      home: const SplashScreen(),  // L'écran de démarrage
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/main', page: () => const MainScreen()),  // Page principale après Splash
      ],
    );
  }
}
