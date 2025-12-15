import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// User model representing a stargazer in the community
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.bio,
    this.location,
    this.latitude,
    this.longitude,
    this.interests = const [],
    this.equipment = const [],
    this.createdAt,
    this.updatedAt,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
  });

  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? bio;
  final String? location;
  final double? latitude;
  final double? longitude;
  final List<String> interests;
  final List<String> equipment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int followersCount;
  final int followingCount;
  final int postsCount;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoUrl,
        bio,
        location,
        latitude,
        longitude,
        interests,
        equipment,
        createdAt,
        updatedAt,
        followersCount,
        followingCount,
        postsCount,
      ];

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? bio,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? interests,
    List<String>? equipment,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? followersCount,
    int? followingCount,
    int? postsCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      interests: interests ?? this.interests,
      equipment: equipment ?? this.equipment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'bio': bio,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'interests': interests,
      'equipment': equipment,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      equipment: (json['equipment'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      followersCount: json['followersCount'] as int? ?? 0,
      followingCount: json['followingCount'] as int? ?? 0,
      postsCount: json['postsCount'] as int? ?? 0,
    );
  }
}
