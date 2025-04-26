// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:baakas_seller/features/shop/screens/messages/chat_screen.dart';
// import '../../../../utils/helpers/helper_functions.dart';

// class ConversationsScreen extends StatelessWidget {
//   final String currentUserId;

//   const ConversationsScreen({super.key, required this.currentUserId});

//   @override
//   Widget build(BuildContext context) {
//     final dark = BaakasHelperFunctions.isDarkMode(context);

//     return Scaffold(
//       backgroundColor: dark ? Colors.grey[900] : Colors.white,
//       appBar: AppBar(
//         backgroundColor: dark ? Colors.grey[900] : Colors.white,
//         centerTitle: true, // <-- Add this line
//         title: Text(
//           'Messages',
//           style: TextStyle(color: dark ? Colors.white : Colors.black),
//         ),
//         elevation: 0,
//       ),

//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance
//                 .collection('messages')
//                 .where('participants', arrayContains: currentUserId)
//                 .orderBy('lastMessageTimestamp', descending: true)
//                 .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'No conversations yet',
//                 style: TextStyle(color: dark ? Colors.white70 : Colors.black54),
//               ),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final conversation = snapshot.data!.docs[index];
//               final otherUserId = (conversation['participants'] as List)
//                   .firstWhere((id) => id != currentUserId);

//               return FutureBuilder<DocumentSnapshot>(
//                 future:
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(otherUserId)
//                         .get(),
//                 builder: (context, userSnapshot) {
//                   if (!userSnapshot.hasData) {
//                     return const SizedBox.shrink();
//                   }

//                   final userData =
//                       userSnapshot.data!.data() as Map<String, dynamic>;
//                   final userName = userData['name'] ?? 'Unknown User';

//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: dark ? Colors.grey[850] : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: dark ? Colors.grey[800]! : Colors.grey[200]!,
//                       ),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         child: Text(
//                           userName[0].toUpperCase(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       title: Text(
//                         userName,
//                         style: TextStyle(
//                           color: dark ? Colors.white : Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         conversation['lastMessage'] ?? 'No messages',
//                         style: TextStyle(
//                           color: dark ? Colors.grey[400] : Colors.grey[600],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       trailing:
//                           conversation['unreadCount'] > 0
//                               ? CircleAvatar(
//                                 radius: 12,
//                                 backgroundColor: Theme.of(context).primaryColor,
//                                 child: Text(
//                                   conversation['unreadCount'].toString(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               )
//                               : null,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => ChatScreen(
//                                   currentUserId: currentUserId,
//                                   otherUserId: otherUserId,
//                                   otherUserName: userName,
//                                 ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/messages_controller.dart';
import 'chat_screen.dart';
import 'widgets/chat_list_item.dart';

class ConversationsScreen extends StatelessWidget {
  final String currentUserId;

  const ConversationsScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    // Initialize MessagesController
    Get.put(MessagesController());

    final dark = BaakasHelperFunctions.isDarkMode(context);
    final controller = Get.find<MessagesController>();

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: dark ? Colors.grey[900] : Colors.white,
        centerTitle: true,
        title: Text(
          'Messages',
          style: TextStyle(color: dark ? Colors.white : Colors.black),
        ),
        elevation: 0,
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.chats.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        size: 64,
                        color: dark ? Colors.white38 : Colors.black38,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No conversations yet',
                        style: TextStyle(
                          color: dark ? Colors.white70 : Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) {
                    final chat = controller.chats[index];
                    final otherUserId = chat.getOtherParticipantId(
                      currentUserId,
                    );

                    return BaakasChatListItem(
                      name:
                          "User $otherUserId", // Replace with actual user name
                      lastMessage: chat.lastMessage?.content ?? 'No messages',
                      time: chat.updatedAt.toString(),
                      unreadCount: chat.getUnreadCount(currentUserId),
                      onTap:
                          () => Get.to(
                            () => ChatScreen(
                              currentUserId: currentUserId,
                              otherUserId: otherUserId,
                              otherUserName:
                                  "User $otherUserId", // Replace with actual user name
                            ),
                          ),
                    );
                  },
                ),
      ),
    );
  }
}
