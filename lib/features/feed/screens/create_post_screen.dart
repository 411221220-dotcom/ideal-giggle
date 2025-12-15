import 'package:flutter/material.dart';

/// Screen for creating a new post
class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: const Center(
        child: Text('Create Post Screen - To be implemented'),
      ),
    );
  }
}
