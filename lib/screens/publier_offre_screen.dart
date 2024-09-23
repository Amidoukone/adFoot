import 'package:flutter/material.dart';

import '../controller/offre_controller.dart';

class PublierOffreScreen extends StatelessWidget {
  final TextEditingController titreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DateTime dateDebut = DateTime.now();
  final DateTime dateFin = DateTime.now().add(Duration(days: 30)); // Durée d'un mois

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publier une Offre')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titreController,
              decoration: InputDecoration(labelText: 'Titre de l\'offre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                OffreController.instance.publierOffre(
                  titreController.text,
                  descriptionController.text,
                  dateDebut,
                  dateFin,
                );
              },
              child: Text('Publier'),
            ),
          ],
        ),
      ),
    );
  }
}
