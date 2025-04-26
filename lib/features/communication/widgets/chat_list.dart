import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_detail_screen.dart';
import '../../../utils/constants/colors.dart';

class ChatList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    if (_currentUserId == null) {
      return const SizedBox.shrink();
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection('Sellers')
              .doc(_currentUserId)
              .collection('chats')
              .orderBy('lastMessageTime', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ChatTile(
                name: 'Customer ${index + 1}',
                lastMessage: 'Last message from customer ${index + 1}',
                time: '${index + 1}m ago',
                unread: index == 0,
              );
            },
          );
        }

        final chats = snapshot.data?.docs ?? [];

        if (chats.isEmpty) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ChatTile(
                name: 'Customer ${index + 1}',
                lastMessage: 'Last message from customer ${index + 1}',
                time: '${index + 1}m ago',
                unread: index == 0,
              );
            },
          );
        }

        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index].data() as Map<String, dynamic>;
            final timestamp = chat['lastMessageTime'] as Timestamp?;
            final time = _formatTimestamp(timestamp);

            return ChatTile(
              name: chat['customerName'] ?? 'Customer ${index + 1}',
              lastMessage:
                  chat['lastMessage'] ??
                  'Last message from customer ${index + 1}',
              time: time,
              unread: chat['unread'] ?? false,
            );
          },
        );
      },
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return '1m ago';

    final now = DateTime.now();
    final date = timestamp.toDate();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;

  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: BaakasColors.primaryColor,
        child: Text(
          name[0].toUpperCase(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
      title: Text(
        name,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: unread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.textTheme.bodySmall?.color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: theme.textTheme.bodySmall),
          if (unread)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: BaakasColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(customerName: name),
          ),
        );
      },
    );
  }
}
