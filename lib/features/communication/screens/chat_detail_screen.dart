import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String customerName;

  const ChatDetailScreen({super.key, required this.customerName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final _logger = Logger();
  late String _chatId;
  bool _isLoading = false;
  bool _isMuted = false;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    _chatId =
        'chat_${_currentUserId}_${widget.customerName.replaceAll(' ', '_')}';
    _loadChatSettings();
  }

  Future<void> _loadChatSettings() async {
    if (_currentUserId == null) return;

    try {
      final chatDoc =
          await _firestore
              .collection('Sellers')
              .doc(_currentUserId)
              .collection('chats')
              .doc(_chatId)
              .get();

      if (chatDoc.exists) {
        setState(() {
          _isMuted = chatDoc.data()?['isMuted'] ?? false;
          _isBlocked = chatDoc.data()?['isBlocked'] ?? false;
        });
      }
    } catch (e) {
      _logger.e('Error loading chat settings: $e');
    }
  }

  Future<void> _toggleMute() async {
    if (_currentUserId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('chats')
          .doc(_chatId)
          .set({'isMuted': !_isMuted}, SetOptions(merge: true));

      if (!mounted) return;
      setState(() => _isMuted = !_isMuted);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isMuted ? 'Chat muted' : 'Chat unmuted'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating mute status: $e')),
      );
    }
  }

  Future<void> _toggleBlock() async {
    if (_currentUserId == null) return;

    try {
      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('chats')
          .doc(_chatId)
          .set({'isBlocked': !_isBlocked}, SetOptions(merge: true));

      if (!mounted) return;
      setState(() => _isBlocked = !_isBlocked);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBlocked ? 'Customer blocked' : 'Customer unblocked'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating block status: $e')),
      );
    }
  }

  Future<void> _deleteChat() async {
    if (_currentUserId == null) return;

    try {
      if (!mounted) return;
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          return AlertDialog(
            title: Text('Delete Chat', style: theme.textTheme.titleLarge),
            content: Text(
              'Are you sure you want to delete this chat? This action cannot be undone.',
              style: theme.textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Delete', style: TextStyle(color: Colors.red[400])),
              ),
            ],
          );
        },
      );

      if (confirm != true) return;

      final messages = await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('chats')
          .doc(_chatId)
          .collection('messages')
          .get();

      final batch = _firestore.batch();
      for (var message in messages.docs) {
        batch.delete(message.reference);
      }

      batch.delete(
        _firestore
            .collection('Sellers')
            .doc(_currentUserId)
            .collection('chats')
            .doc(_chatId),
      );

      await batch.commit();

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting chat: $e')),
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _currentUserId == null) return;

    setState(() => _isLoading = true);

    try {
      final String message = _messageController.text.trim();
      _messageController.clear();

      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('chats')
          .doc(_chatId)
          .set({
            'lastMessage': message,
            'lastMessageTime': FieldValue.serverTimestamp(),
            'customerName': widget.customerName,
            'customerId': widget.customerName.replaceAll(' ', '_').toLowerCase(),
            'unread': false,
          }, SetOptions(merge: true));

      await _firestore
          .collection('Sellers')
          .doc(_currentUserId)
          .collection('chats')
          .doc(_chatId)
          .collection('messages')
          .add({
            'message': message,
            'timestamp': FieldValue.serverTimestamp(),
            'senderId': _currentUserId,
            'senderName': 'Seller',
          });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: BaakasAppBar(
        showBackArrow: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: BaakasColors.primaryColor.withOpacity(0.1),
              child: const Icon(Iconsax.user, color: BaakasColors.primaryColor),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.customerName),
                if (_isBlocked)
                  Text(
                    'Blocked',
                    style: TextStyle(fontSize: 12, color: Colors.red[400]),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Iconsax.more),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'mute',
                    child: Row(
                      children: [
                        Icon(
                          _isMuted ? Iconsax.volume_cross : Iconsax.volume_high,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(_isMuted ? 'Unmute' : 'Mute'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'block',
                    child: Row(
                      children: [
                        Icon(
                          _isBlocked ? Iconsax.user_tick : Iconsax.user_minus,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(_isBlocked ? 'Unblock' : 'Block'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Iconsax.trash, size: 20, color: Colors.red[400]),
                        const SizedBox(width: 12),
                        Text(
                          'Delete Chat',
                          style: TextStyle(color: Colors.red[400]),
                        ),
                      ],
                    ),
                  ),
                ],
            onSelected: (value) async {
              switch (value) {
                case 'mute':
                  await _toggleMute();
                  break;
                case 'block':
                  await _toggleBlock();
                  break;
                case 'delete':
                  await _deleteChat();
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isBlocked)
            Container(
              color: Colors.red[400]?.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Icon(Iconsax.user_minus, size: 20, color: Colors.red[400]),
                  const SizedBox(width: 8),
                  Text(
                    'You have blocked this customer',
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ],
              ),
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore
                      .collection('Sellers')
                      .doc(_currentUserId)
                      .collection('chats')
                      .doc(_chatId)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;
                    final isMe = message['senderId'] == _currentUserId;
                    final timestamp = message['timestamp'] as Timestamp?;
                    final time =
                        timestamp != null
                            ? '${timestamp.toDate().hour}:${timestamp.toDate().minute.toString().padLeft(2, '0')}'
                            : '';

                    return _MessageBubble(
                      message: message['message'] as String,
                      isMe: isMe,
                      time: time,
                    );
                  },
                );
              },
            ),
          ),
          if (!_isBlocked)
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: theme.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          hintText: 'Type a message...',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                      color: BaakasColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon:
                          _isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Icon(
                                Iconsax.send1,
                                color: theme.colorScheme.onPrimary,
                                size: 20,
                              ),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: BaakasColors.primaryColor,
              child: Icon(
                Iconsax.user,
                size: 16,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color:
                  isMe ? BaakasColors.primaryColor : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color:
                        isMe
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        isMe
                            ? theme.colorScheme.onPrimary.withOpacity(0.7)
                            : theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
