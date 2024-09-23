import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Rx<User?> _user;  // Rx pour observer l'état de l'utilisateur Firebase

  @override
  void initState() {
    super.initState();
    onReady();  // Appel de la méthode pour surveiller l'état de connexion
  }

  void onReady() {
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);  // Suivi de l'utilisateur courant
    _user.bindStream(FirebaseAuth.instance.authStateChanges());  // Suivi des changements d'état d'authentification
    ever(_user, _setInitialScreen);  // Réagir aux changements de l'état utilisateur
  }

  // Rediriger en fonction de la connexion de l'utilisateur
  _setInitialScreen(User? user) {
    Timer(const Duration(seconds: 2), () {
      if (user == null) {
        Get.offAll(() => const LoginScreen());  // Si l'utilisateur n'est pas connecté, on redirige vers le login
      } else {
        Get.offAll(() => const HomeScreen());  // Sinon on redirige vers l'écran d'accueil
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,  // Couleur de fond (à personnaliser)
      body: Center(
        child: Image.asset(
          'assets/logo.png',  // Logo de ton application (assure-toi que le chemin est correct)
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
