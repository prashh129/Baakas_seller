import 'package:flutter/material.dart';
import '../widgets/chat_list.dart';

class CustomerCommunicationScreen extends StatelessWidget {
  const CustomerCommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Chats',
          style: theme.textTheme.headlineSmall,
        ),
      ),
      body: ChatList(),
    );
  }
}
