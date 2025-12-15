import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Group model for astronomy communities
class GroupModel extends Equatable {
  const GroupModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.creatorId,
    required this.creatorName,
    this.category,
    this.location,
    this.latitude,
    this.longitude,
    this.memberIds = const [],
    this.adminIds = const [],
    required this.createdAt,
    this.updatedAt,
    this.isPublic = true,
    this.isJoined = false,
  });

  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String creatorId;
  final String creatorName;
  final String? category;
  final String? location;
  final double? latitude;
  final double? longitude;
  final List<String> memberIds;
  final List<String> adminIds;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isPublic;
  final bool isJoined;

  int get membersCount => memberIds.length;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        creatorId,
        creatorName,
        category,
        location,
        latitude,
        longitude,
        memberIds,
        adminIds,
        createdAt,
        updatedAt,
        isPublic,
        isJoined,
      ];

  GroupModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? creatorId,
    String? creatorName,
    String? category,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? memberIds,
    List<String>? adminIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPublic,
    bool? isJoined,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      category: category ?? this.category,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      memberIds: memberIds ?? this.memberIds,
      adminIds: adminIds ?? this.adminIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPublic: isPublic ?? this.isPublic,
      isJoined: isJoined ?? this.isJoined,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'creatorId': creatorId,
      'creatorName': creatorName,
      'category': category,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'memberIds': memberIds,
      'adminIds': adminIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'isPublic': isPublic,
    };
  }

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String,
      category: json['category'] as String?,
      location: json['location'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      adminIds: (json['adminIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      isPublic: json['isPublic'] as bool? ?? true,
      isJoined: json['isJoined'] as bool? ?? false,
    );
  }
}
