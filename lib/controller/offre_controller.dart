import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/offre.dart';
import '../models/user.dart';
import '../controller/auth_controller.dart';

class OffreController extends GetxController {
  static OffreController instance = Get.find();
  
  RxList<Offre> offres = <Offre>[].obs; // Liste des offres récupérées

  // Méthode pour récupérer toutes les offres
  Future<void> getAllOffres() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('offres').get();
    offres.value = snapshot.docs
        .map((doc) => Offre.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Méthode pour publier une nouvelle offre
  Future<void> publierOffre(String titre, String description, DateTime dateDebut, DateTime dateFin) async {
    String id = FirebaseFirestore.instance.collection('offres').doc().id;
    AppUser recruteur = AuthController.instance.user as AppUser; // Utilisateur connecté (recruteur)

    Offre newOffre = Offre(
      id: id,
      titre: titre,
      description: description,
      dateDebut: dateDebut,
      dateFin: dateFin,
      recruteur: recruteur,
      candidats: [],
      statut: 'ouverte',
    );

    await FirebaseFirestore.instance
        .collection('offres')
        .doc(id)
        .set(newOffre.toMap());

    // Envoyer des notifications aux joueurs
    // Ici, vous pouvez déclencher Firebase Cloud Messaging pour alerter les joueurs

    Get.snackbar('Succès', 'Offre publiée avec succès');
    getAllOffres(); // Mettre à jour la liste des offres
  }

  // Méthode pour postuler à une offre
  Future<void> postulerOffre(Offre offre) async {
    AppUser joueur = AuthController.instance.user as AppUser; // Joueur connecté

    if (!offre.candidats.contains(joueur)) {
      offre.candidats.add(joueur);

      await FirebaseFirestore.instance
          .collection('offres')
          .doc(offre.id)
          .update({'candidats': offre.candidats.map((j) => j.toMap()).toList()});

      Get.snackbar('Succès', 'Vous avez postulé à l\'offre');
    } else {
      Get.snackbar('Erreur', 'Vous avez déjà postulé à cette offre');
    }
  }

  // Méthode pour fermer une offre
  Future<void> fermerOffre(Offre offre) async {
    offre.statut = 'fermée';
    await FirebaseFirestore.instance
        .collection('offres')
        .doc(offre.id)
        .update({'statut': 'fermée'});

    Get.snackbar('Offre fermée', 'L\'offre a été fermée avec succès');
  }
}
