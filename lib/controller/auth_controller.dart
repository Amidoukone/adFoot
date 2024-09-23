import 'dart:io';

import 'package:ad_foot/screens/home_screen.dart';
import 'package:ad_foot/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../models/user.dart'; // Modèle AppUser


class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);  // Instance Firebase Auth
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // Méthode pour choisir une image de profil
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Image Added Successfully');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // Méthode pour uploader l'image dans Firebase Storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePictures')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Méthode pour enregistrer un utilisateur avec un rôle
  void registerUser(String name, String email, String password, String role, File? image) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null && role.isNotEmpty) {
        // Création d'un utilisateur Firebase
        UserCredential userCred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Upload de l'image de profil
        String downloadUrl = await _uploadToStorage(image);

        // Création de l'objet AppUser
        AppUser newUser = AppUser(
          uid: userCred.user!.uid,
          name: name,
          email: email,
          role: role,  // Ajout du rôle ici
          profilePhoto: downloadUrl,
          followers: [],
          following: [],
        );

        // Enregistrement de l'utilisateur dans Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCred.user!.uid)
            .set(newUser.toMap());

        Get.snackbar('Bienvenue', 'Votre compte a été créé avec succès');
        Get.to(() => HomeScreen());
      } else {
        Get.snackbar('Erreur', 'Veuillez remplir tous les champs et ajouter une photo');
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
  }

  // Méthode pour se connecter
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        Get.to(() => HomeScreen());
      } else {
        Get.snackbar('Erreur', 'Veuillez remplir toutes les informations');
      }
    } catch (e) {
      Get.snackbar('Erreur de connexion', e.toString());
    }
  }

  // Méthode pour se déconnecter
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
