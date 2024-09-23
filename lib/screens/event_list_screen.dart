import 'package:ad_foot/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ad_foot/models/event.dart';

class EventListScreen extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Événements')),
      body: Obx(() {
        if (eventController.events.isEmpty) {
          return Center(child: Text('Aucun événement disponible pour l\'instant.'));
        } else {
          return ListView.builder(
            itemCount: eventController.events.length,
            itemBuilder: (context, index) {
              Event event = eventController.events[index];
              return ListTile(
                title: Text(event.titre),
                subtitle: Text(event.description),
                trailing: Text(event.statut),
                onTap: () {
                  // Afficher les détails de l'événement ou permettre l'inscription
                },
              );
            },
          );
        }
      }),
    );
  }
}
