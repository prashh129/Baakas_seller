import 'message.dart';

class Chat {
  final String id;
  final List<String> participants;
  final Message? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, bool> isBlocked;
  final Map<String, int> unreadCount;

  Chat({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.isBlocked,
    required this.unreadCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      participants: List<String>.from(json['participants'] as List),
      lastMessage:
          json['lastMessage'] != null
              ? Message.fromJson(json['lastMessage'] as Map<String, dynamic>)
              : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isBlocked: Map<String, bool>.from(json['isBlocked'] as Map),
      unreadCount: Map<String, int>.from(json['unreadCount'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isBlocked': isBlocked,
      'unreadCount': unreadCount,
    };
  }

  String getOtherParticipantId(String currentUserId) {
    return participants.firstWhere((id) => id != currentUserId);
  }

  bool isBlockedByUser(String userId) {
    return isBlocked[userId] ?? false;
  }

  int getUnreadCount(String userId) {
    return unreadCount[userId] ?? 0;
  }
}
