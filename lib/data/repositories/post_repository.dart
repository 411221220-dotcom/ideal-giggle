import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/post_model.dart';
import '../../core/constants/app_constants.dart';

/// Repository for post operations
class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  /// Get posts stream (for real-time updates)
  Stream<List<PostModel>> getPostsStream({int limit = 20}) {
    return _firestore
        .collection(AppConstants.postsCollection)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get posts paginated
  Future<List<PostModel>> getPosts({
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _firestore
        .collection(AppConstants.postsCollection)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Get user posts
  Future<List<PostModel>> getUserPosts(String userId) async {
    final snapshot = await _firestore
        .collection(AppConstants.postsCollection)
        .where('authorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => PostModel.fromJson(doc.data()))
        .toList();
  }

  /// Create post
  Future<PostModel> createPost({
    required String authorId,
    required String authorName,
    String? authorPhotoUrl,
    required String content,
    List<File>? images,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? equipmentUsed,
  }) async {
    try {
      final postId = _uuid.v4();
      
      // Upload images if provided
      final imageUrls = <String>[];
      if (images != null && images.isNotEmpty) {
        for (final image in images) {
          final url = await _uploadImage(image, postId);
          imageUrls.add(url);
        }
      }

      final post = PostModel(
        id: postId,
        authorId: authorId,
        authorName: authorName,
        authorPhotoUrl: authorPhotoUrl,
        content: content,
        imageUrls: imageUrls,
        location: location,
        latitude: latitude,
        longitude: longitude,
        equipmentUsed: equipmentUsed ?? [],
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection(AppConstants.postsCollection)
          .doc(postId)
          .set(post.toJson());

      // Update user posts count
      await _incrementUserPostsCount(authorId);

      return post;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  /// Upload image to Firebase Storage
  Future<String> _uploadImage(File image, String postId) async {
    final fileName = '${_uuid.v4()}.jpg';
    final ref = _storage
        .ref()
        .child(AppConstants.postImagesPath)
        .child(postId)
        .child(fileName);

    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  /// Like post
  Future<void> likePost(String postId, String userId) async {
    final postRef =
        _firestore.collection(AppConstants.postsCollection).doc(postId);
    final likeRef = postRef.collection(AppConstants.likesCollection).doc(userId);

    await _firestore.runTransaction((transaction) async {
      final postDoc = await transaction.get(postRef);
      if (!postDoc.exists) return;

      final likesCount = postDoc.data()?['likesCount'] as int? ?? 0;
      transaction.update(postRef, {'likesCount': likesCount + 1});
      transaction.set(likeRef, {
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  /// Unlike post
  Future<void> unlikePost(String postId, String userId) async {
    final postRef =
        _firestore.collection(AppConstants.postsCollection).doc(postId);
    final likeRef = postRef.collection(AppConstants.likesCollection).doc(userId);

    await _firestore.runTransaction((transaction) async {
      final postDoc = await transaction.get(postRef);
      if (!postDoc.exists) return;

      final likesCount = postDoc.data()?['likesCount'] as int? ?? 0;
      transaction.update(postRef, {'likesCount': likesCount > 0 ? likesCount - 1 : 0});
      transaction.delete(likeRef);
    });
  }

  /// Delete post
  Future<void> deletePost(String postId) async {
    await _firestore.collection(AppConstants.postsCollection).doc(postId).delete();
    
    // TODO: Delete associated images from storage
    // TODO: Update user posts count
  }

  /// Increment user posts count
  Future<void> _incrementUserPostsCount(String userId) async {
    final userRef =
        _firestore.collection(AppConstants.usersCollection).doc(userId);
    await userRef.update({
      'postsCount': FieldValue.increment(1),
    });
  }
}
