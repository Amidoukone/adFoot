import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ad_foot/screens/signup_screen.dart'; // Assurez-vous que le fichier signup_screen.dart contient la classe SignUpScreen avec le bon nom.

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class Routes {
  static const String login = '/login'; // Route pour la page de connexion
  static const String signup = '/signup'; // Route pour la page d'inscription
  static const String home = '/home'; // Route pour la page d'accueil
  static const String confirm = '/confirm'; // Route pour la confirmation
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.login:
        return PageTransition(
          child: const LoginScreen(), // Page de connexion
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 1000),
        );
      case Routes.signup:
        return PageTransition(
          child: const SignUpScreen(), // Notez ici le bon nom de la classe : SignUpScreen
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 1000),
        );
      case Routes.home:
        return PageTransition(
          child: const HomeScreen(), // Page d'accueil
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 1000),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Page Found'), // Titre pour la page non définie
        ),
        body: const Center(
          child: Text('No Page Found'), // Message d'erreur
        ),
      ),
    );
  }
}
