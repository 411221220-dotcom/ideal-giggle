import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/group_model.dart';
import '../../core/constants/app_constants.dart';

/// Repository for group operations
class GroupRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  /// Get groups stream
  Stream<List<GroupModel>> getGroupsStream() {
    return _firestore
        .collection(AppConstants.groupsCollection)
        .where('isPublic', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => GroupModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get all groups
  Future<List<GroupModel>> getGroups({int limit = 20}) async {
    final snapshot = await _firestore
        .collection(AppConstants.groupsCollection)
        .where('isPublic', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => GroupModel.fromJson(doc.data()))
        .toList();
  }

  /// Get user groups
  Future<List<GroupModel>> getUserGroups(String userId) async {
    final snapshot = await _firestore
        .collection(AppConstants.groupsCollection)
        .where('memberIds', arrayContains: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => GroupModel.fromJson(doc.data()))
        .toList();
  }

  /// Get group by ID
  Future<GroupModel> getGroupById(String groupId) async {
    final doc = await _firestore
        .collection(AppConstants.groupsCollection)
        .doc(groupId)
        .get();

    if (!doc.exists) {
      throw Exception('Group not found');
    }

    return GroupModel.fromJson(doc.data()!);
  }

  /// Create group
  Future<GroupModel> createGroup({
    required String name,
    required String description,
    required String creatorId,
    required String creatorName,
    String? category,
    String? location,
    double? latitude,
    double? longitude,
    bool isPublic = true,
  }) async {
    final groupId = _uuid.v4();

    final group = GroupModel(
      id: groupId,
      name: name,
      description: description,
      creatorId: creatorId,
      creatorName: creatorName,
      category: category,
      location: location,
      latitude: latitude,
      longitude: longitude,
      memberIds: [creatorId], // Creator is automatically a member
      adminIds: [creatorId], // Creator is automatically an admin
      createdAt: DateTime.now(),
      isPublic: isPublic,
    );

    await _firestore
        .collection(AppConstants.groupsCollection)
        .doc(groupId)
        .set(group.toJson());

    return group;
  }

  /// Join group
  Future<void> joinGroup(String groupId, String userId) async {
    final groupRef =
        _firestore.collection(AppConstants.groupsCollection).doc(groupId);

    await _firestore.runTransaction((transaction) async {
      final groupDoc = await transaction.get(groupRef);
      if (!groupDoc.exists) return;

      final memberIds =
          List<String>.from(groupDoc.data()?['memberIds'] as List? ?? []);

      if (!memberIds.contains(userId)) {
        memberIds.add(userId);
        transaction.update(groupRef, {'memberIds': memberIds});
      }
    });
  }

  /// Leave group
  Future<void> leaveGroup(String groupId, String userId) async {
    final groupRef =
        _firestore.collection(AppConstants.groupsCollection).doc(groupId);

    await _firestore.runTransaction((transaction) async {
      final groupDoc = await transaction.get(groupRef);
      if (!groupDoc.exists) return;

      final memberIds =
          List<String>.from(groupDoc.data()?['memberIds'] as List? ?? []);
      final adminIds =
          List<String>.from(groupDoc.data()?['adminIds'] as List? ?? []);

      memberIds.remove(userId);
      adminIds.remove(userId);

      transaction.update(groupRef, {
        'memberIds': memberIds,
        'adminIds': adminIds,
      });
    });
  }

  /// Delete group
  Future<void> deleteGroup(String groupId) async {
    await _firestore
        .collection(AppConstants.groupsCollection)
        .doc(groupId)
        .delete();
  }
}
