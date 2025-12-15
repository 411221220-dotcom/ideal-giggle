import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Event model for astronomical events and meetups
class EventModel extends Equatable {
  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventType,
    required this.startDateTime,
    this.endDateTime,
    this.location,
    this.latitude,
    this.longitude,
    this.imageUrl,
    required this.organizerId,
    required this.organizerName,
    this.organizerPhotoUrl,
    this.attendeeIds = const [],
    this.maxAttendees,
    required this.createdAt,
    this.updatedAt,
    this.isPublic = true,
    this.isAttending = false,
  });

  final String id;
  final String title;
  final String description;
  final String eventType;
  final DateTime startDateTime;
  final DateTime? endDateTime;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final String organizerId;
  final String organizerName;
  final String? organizerPhotoUrl;
  final List<String> attendeeIds;
  final int? maxAttendees;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isPublic;
  final bool isAttending;

  int get attendeesCount => attendeeIds.length;
  bool get isFull =>
      maxAttendees != null && attendeesCount >= maxAttendees!;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        eventType,
        startDateTime,
        endDateTime,
        location,
        latitude,
        longitude,
        imageUrl,
        organizerId,
        organizerName,
        organizerPhotoUrl,
        attendeeIds,
        maxAttendees,
        createdAt,
        updatedAt,
        isPublic,
        isAttending,
      ];

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? eventType,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? location,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? organizerId,
    String? organizerName,
    String? organizerPhotoUrl,
    List<String>? attendeeIds,
    int? maxAttendees,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublic,
    bool? isAttending,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      eventType: eventType ?? this.eventType,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      organizerId: organizerId ?? this.organizerId,
      organizerName: organizerName ?? this.organizerName,
      organizerPhotoUrl: organizerPhotoUrl ?? this.organizerPhotoUrl,
      attendeeIds: attendeeIds ?? this.attendeeIds,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublic: isPublic ?? this.isPublic,
      isAttending: isAttending ?? this.isAttending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'eventType': eventType,
      'startDateTime': Timestamp.fromDate(startDateTime),
      'endDateTime':
          endDateTime != null ? Timestamp.fromDate(endDateTime!) : null,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'organizerId': organizerId,
      'organizerName': organizerName,
      'organizerPhotoUrl': organizerPhotoUrl,
      'attendeeIds': attendeeIds,
      'maxAttendees': maxAttendees,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isPublic': isPublic,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      eventType: json['eventType'] as String,
      startDateTime: (json['startDateTime'] as Timestamp).toDate(),
      endDateTime: json['endDateTime'] != null
          ? (json['endDateTime'] as Timestamp).toDate()
          : null,
      location: json['location'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      imageUrl: json['imageUrl'] as String?,
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String,
      organizerPhotoUrl: json['organizerPhotoUrl'] as String?,
      attendeeIds: (json['attendeeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxAttendees: json['maxAttendees'] as int?,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      isPublic: json['isPublic'] as bool? ?? true,
      isAttending: json['isAttending'] as bool? ?? false,
    );
  }
}
