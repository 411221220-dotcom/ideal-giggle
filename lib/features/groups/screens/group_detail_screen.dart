import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({required this.groupId, super.key});
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Group Details')),
      body: Center(child: Text('Group: $groupId')),
    );
  }
}
