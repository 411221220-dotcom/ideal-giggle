import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/event_model.dart';
import '../../core/constants/app_constants.dart';

/// Repository for event operations
class EventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  /// Get events stream
  Stream<List<EventModel>> getEventsStream() {
    return _firestore
        .collection(AppConstants.eventsCollection)
        .where('startDateTime', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('startDateTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get upcoming events
  Future<List<EventModel>> getUpcomingEvents({int limit = 20}) async {
    final snapshot = await _firestore
        .collection(AppConstants.eventsCollection)
        .where('startDateTime', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('startDateTime')
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => EventModel.fromJson(doc.data()))
        .toList();
  }

  /// Get event by ID
  Future<EventModel> getEventById(String eventId) async {
    final doc = await _firestore
        .collection(AppConstants.eventsCollection)
        .doc(eventId)
        .get();

    if (!doc.exists) {
      throw Exception('Event not found');
    }

    return EventModel.fromJson(doc.data()!);
  }

  /// Create event
  Future<EventModel> createEvent({
    required String title,
    required String description,
    required String eventType,
    required DateTime startDateTime,
    DateTime? endDateTime,
    String? location,
    double? latitude,
    double? longitude,
    required String organizerId,
    required String organizerName,
    String? organizerPhotoUrl,
    int? maxAttendees,
    bool isPublic = true,
  }) async {
    final eventId = _uuid.v4();

    final event = EventModel(
      id: eventId,
      title: title,
      description: description,
      eventType: eventType,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      location: location,
      latitude: latitude,
      longitude: longitude,
      organizerId: organizerId,
      organizerName: organizerName,
      organizerPhotoUrl: organizerPhotoUrl,
      attendeeIds: [organizerId], // Organizer is automatically attending
      maxAttendees: maxAttendees,
      createdAt: DateTime.now(),
      isPublic: isPublic,
    );

    await _firestore
        .collection(AppConstants.eventsCollection)
        .doc(eventId)
        .set(event.toJson());

    return event;
  }

  /// RSVP to event
  Future<void> rsvpEvent(String eventId, String userId) async {
    final eventRef =
        _firestore.collection(AppConstants.eventsCollection).doc(eventId);

    await _firestore.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventRef);
      if (!eventDoc.exists) return;

      final attendeeIds =
          List<String>.from(eventDoc.data()?['attendeeIds'] as List? ?? []);

      if (!attendeeIds.contains(userId)) {
        attendeeIds.add(userId);
        transaction.update(eventRef, {'attendeeIds': attendeeIds});
      }
    });
  }

  /// Cancel RSVP
  Future<void> cancelRsvp(String eventId, String userId) async {
    final eventRef =
        _firestore.collection(AppConstants.eventsCollection).doc(eventId);

    await _firestore.runTransaction((transaction) async {
      final eventDoc = await transaction.get(eventRef);
      if (!eventDoc.exists) return;

      final attendeeIds =
          List<String>.from(eventDoc.data()?['attendeeIds'] as List? ?? []);

      if (attendeeIds.contains(userId)) {
        attendeeIds.remove(userId);
        transaction.update(eventRef, {'attendeeIds': attendeeIds});
      }
    });
  }

  /// Delete event
  Future<void> deleteEvent(String eventId) async {
    await _firestore
        .collection(AppConstants.eventsCollection)
        .doc(eventId)
        .delete();
  }
}
