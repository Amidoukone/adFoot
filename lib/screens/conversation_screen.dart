import 'package:ad_foot/controller/chat_controller.dart';
import 'package:ad_foot/models/user.dart';
import 'package:ad_foot/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ad_foot/models/conversation.dart';

class ConversationsScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversations')),
      body: Obx(() {
        if (chatController.conversations.isEmpty) {
          return const Center(child: Text('Aucune conversation disponible.'));
        } else {
          return ListView.builder(
            itemCount: chatController.conversations.length,
            itemBuilder: (context, index) {
              Conversation conversation = chatController.conversations[index];

              // Déterminer quel utilisateur est l'utilisateur actuel et l'autre utilisateur
              AppUser currentUser = chatController.currentUser; // Utilisateur actuel
              AppUser otherUser = conversation.utilisateur1.uid == currentUser.uid
                  ? conversation.utilisateur2
                  : conversation.utilisateur1;

              return ListTile(
                title: Text(
                    '${conversation.utilisateur1.name} - ${conversation.utilisateur2.name}'),
                onTap: () {
                  // Ouvrir la conversation pour afficher les messages et passer les utilisateurs
                  Get.to(() => ChatScreen(
                    conversationId: conversation.id,
                    currentUser: currentUser,
                    otherUser: otherUser,
                  ));
                },
              );
            },
          );
        }
      }),
    );
  }
}
