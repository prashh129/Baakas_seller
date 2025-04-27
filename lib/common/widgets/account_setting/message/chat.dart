import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String sellerName;
  const ChatScreen({super.key, required this.sellerName});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {'sender': 'buyer', 'text': 'Hi! Is the red dress still available?'},
      {'sender': 'seller', 'text': 'Yes, it is! We have all sizes in stock.'},
      {'sender': 'buyer', 'text': 'Great! What fabric is it made of?'},
      {'sender': 'seller', 'text': "It's made of premium cotton blend."},
      {'sender': 'buyer', 'text': "Perfect. I'll place an order now. Thanks!"},
      {'sender': 'seller', 'text': "You're welcome! 😊"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with $sellerName'),
        iconTheme: IconThemeData(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[index];
            final isBuyer = msg['sender'] == 'buyer';

            return Align(
              alignment: isBuyer ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color:
                      isBuyer
                          ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 26)
                          : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft:
                        isBuyer ? const Radius.circular(16) : Radius.zero,
                    bottomRight:
                        isBuyer ? Radius.zero : const Radius.circular(16),
                  ),
                ),
                child: Text(
                  msg['text']!,
                  style: TextStyle(
                    color: isBuyer ? Colors.green : Colors.black87,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
