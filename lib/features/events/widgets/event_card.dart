import 'package:flutter/material.dart';
import '../../../data/models/event_model.dart';
import '../../../core/utils/helpers.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.event),
        title: Text(event.title),
        subtitle: Text(Helpers.formatDateTime(event.startDateTime)),
        trailing: Text('${event.attendeesCount} attending'),
      ),
    );
  }
}
