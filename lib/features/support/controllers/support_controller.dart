import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

enum SupportTicketStatus { open, inProgress, resolved, closed }

class SupportTicket {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final SupportTicketStatus status;
  final List<SupportMessage> messages;
  final String sellerId;

  SupportTicket({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    required this.messages,
    required this.sellerId,
  });

  factory SupportTicket.fromMap(Map<String, dynamic> map) {
    return SupportTicket(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: SupportTicketStatus.values.firstWhere(
        (e) => e.toString() == 'SupportTicketStatus.${map['status']}',
        orElse: () => SupportTicketStatus.open,
      ),
      messages:
          (map['messages'] as List<dynamic>? ?? [])
              .map((m) => SupportMessage.fromMap(m))
              .toList(),
      sellerId: map['sellerId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.toString().split('.').last,
      'messages': messages.map((m) => m.toMap()).toList(),
      'sellerId': sellerId,
    };
  }
}

class SupportMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isFromSupport;

  SupportMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isFromSupport,
  });

  factory SupportMessage.fromMap(Map<String, dynamic> map) {
    return SupportMessage(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isFromSupport: map['isFromSupport'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'isFromSupport': isFromSupport,
    };
  }
}

class FAQ {
  final String id;
  final String question;
  final String answer;
  final String category;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
  });

  factory FAQ.fromMap(Map<String, dynamic> map) {
    return FAQ(
      id: map['id'] ?? '',
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
    };
  }
}

class Guide {
  final String id;
  final String title;
  final String content;
  final String category;

  Guide({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
  });

  factory Guide.fromMap(Map<String, dynamic> map) {
    return Guide(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content, 'category': category};
  }
}

class SupportController extends GetxController {
  final _logger = Logger();
  final RxList<SupportTicket> tickets = <SupportTicket>[].obs;
  final RxList<FAQ> faqs = <FAQ>[].obs;
  final RxList<Guide> guides = <Guide>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;

  String get _sellerId => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    if (_sellerId.isNotEmpty) {
      loadFAQs();
      loadGuides();
      loadTickets();
    }
  }

  Future<void> loadFAQs() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore.collection('FAQs').get();
      faqs.value = snapshot.docs
          .map((doc) => FAQ.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      _logger.e('Error loading FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadGuides() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore.collection('Guides').get();
      guides.value = snapshot.docs
          .map((doc) => Guide.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      _logger.e('Error loading guides: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTickets() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore
          .collection('Sellers')
          .doc(_sellerId)
          .collection('SupportTickets')
          .orderBy('createdAt', descending: true)
          .get();
      tickets.value = snapshot.docs
          .map((doc) => SupportTicket.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      _logger.e('Error loading tickets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNewTicket(String title, String description) async {
    try {
      isLoading.value = true;
      final docRef = await _firestore
          .collection('Sellers')
          .doc(_sellerId)
          .collection('SupportTickets')
          .add({
            'title': title,
            'description': description,
            'createdAt': Timestamp.fromDate(DateTime.now()),
            'status': SupportTicketStatus.open.toString().split('.').last,
            'messages': [],
            'sellerId': _sellerId,
          });

      final ticket = SupportTicket(
        id: docRef.id,
        title: title,
        description: description,
        createdAt: DateTime.now(),
        status: SupportTicketStatus.open,
        messages: [],
        sellerId: _sellerId,
      );

      tickets.insert(0, ticket);
    } catch (e) {
      _logger.e('Error creating ticket: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String ticketId, String message) async {
    try {
      final supportMessage = SupportMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: message,
        timestamp: DateTime.now(),
        isFromSupport: false,
      );

      await _firestore
          .collection('Sellers')
          .doc(_sellerId)
          .collection('SupportTickets')
          .doc(ticketId)
          .update({
            'messages': FieldValue.arrayUnion([supportMessage.toMap()]),
          });

      final ticketIndex = tickets.indexWhere((t) => t.id == ticketId);
      if (ticketIndex != -1) {
        tickets[ticketIndex].messages.add(supportMessage);
        tickets.refresh();
      }
    } catch (e) {
      _logger.e('Error sending message: $e');
      rethrow;
    }
  }
}
