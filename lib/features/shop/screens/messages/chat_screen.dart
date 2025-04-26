import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/messages_controller.dart';
import '../../../../common/widgets/custom_containers/primary_container.dart';

class ChatScreen extends StatelessWidget {
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;

  const ChatScreen({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MessagesController>();
    final chatId = '${currentUserId}_$otherUserId';

    return Scaffold(
      appBar: AppBar(title: Text(otherUserName), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              controller.loadMessages(chatId);
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isMe = message.senderId == currentUserId;

                  return BaakasPrimaryContainer(
                    margin: EdgeInsets.only(
                      left: isMe ? 48 : 8,
                      right: isMe ? 8 : 48,
                      bottom: 8,
                    ),
                    child: Text(message.content),
                  );
                },
              );
            }),
          ),
          _buildMessageInput(controller, chatId),
        ],
      ),
    );
  }

  Widget _buildMessageInput(MessagesController controller, String chatId) {
    final textController = TextEditingController();

    return BaakasPrimaryContainer(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                controller.sendMessage(chatId, textController.text.trim());
                textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
