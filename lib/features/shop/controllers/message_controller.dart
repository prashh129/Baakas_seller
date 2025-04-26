import 'package:get/get.dart';

class MessageController extends GetxController {
  static MessageController get instance => Get.find();

  // Observable message count
  final RxInt messageCount = 0.obs;

  // Example method to update message count (you can modify this based on your backend)
  void updateMessageCount(int count) {
    messageCount.value = count;
  }

  // Method to mark messages as read
  void markAsRead() {
    messageCount.value = 0;
  }

  // Method to increment message count (for testing)
  void incrementMessageCount() {
    messageCount.value++;
  }
}
