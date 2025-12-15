import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.conversationId, super.key});
  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Center(child: Text('Chat: $conversationId')),
    );
  }
}
