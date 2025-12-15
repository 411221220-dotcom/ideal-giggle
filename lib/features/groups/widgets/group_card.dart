import 'package:flutter/material.dart';
import '../../../data/models/group_model.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({required this.group, super.key});
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.groups),
        title: Text(group.name),
        subtitle: Text(group.description),
        trailing: Text('${group.membersCount} members'),
      ),
    );
  }
}
