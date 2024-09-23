import 'firebase_options.dart'; // Le fichier généré pour configurer Firebase
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';  // N'oublie pas d'initialiser Firebase
import 'package:ad_foot/screens/splash_screen.dart';
import 'package:ad_foot/controller/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Utilisation des options spécifiques à la plateforme (comme le Web)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialisation de GetX pour la gestion de l'état global
  Get.put(UserController());  // Instancie le contrôleur User globalement

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Utilisation de GetMaterialApp pour la navigation
      title: 'Ad Foot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),  // Lancement de l'application avec l'écran de démarrage
    );
  }
}
