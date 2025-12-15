import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/message_model.dart';
import '../../core/constants/app_constants.dart';

/// Repository for chat operations
class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  /// Get messages stream for a conversation
  Stream<List<MessageModel>> getMessagesStream(String conversationId) {
    return _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId)
        .collection(AppConstants.messagesCollection)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Get messages paginated
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    int limit = 50,
    DocumentSnapshot? lastDocument,
  }) async {
    Query query = _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId)
        .collection(AppConstants.messagesCollection)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => MessageModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Send message
  Future<MessageModel> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    String? senderPhotoUrl,
    required String content,
  }) async {
    final messageId = _uuid.v4();

    final message = MessageModel(
      id: messageId,
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      senderPhotoUrl: senderPhotoUrl,
      content: content,
      timestamp: DateTime.now(),
    );

    await _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId)
        .collection(AppConstants.messagesCollection)
        .doc(messageId)
        .set(message.toJson());

    // Update conversation last message
    await _updateConversationLastMessage(conversationId, message);

    return message;
  }

  /// Update conversation last message
  Future<void> _updateConversationLastMessage(
    String conversationId,
    MessageModel message,
  ) async {
    await _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId)
        .update({
      'lastMessage': message.content,
      'lastMessageTimestamp': Timestamp.fromDate(message.timestamp),
      'lastMessageSenderId': message.senderId,
    });
  }

  /// Mark message as read
  Future<void> markMessageAsRead(String conversationId, String messageId) async {
    await _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId)
        .collection(AppConstants.messagesCollection)
        .doc(messageId)
        .update({
      'isRead': true,
      'readAt': FieldValue.serverTimestamp(),
    });
  }

  /// Create or get conversation
  Future<String> createOrGetConversation({
    required List<String> participantIds,
  }) async {
    // Sort participant IDs to create consistent conversation ID
    participantIds.sort();
    final conversationId = participantIds.join('_');

    final conversationRef = _firestore
        .collection(AppConstants.conversationsCollection)
        .doc(conversationId);

    final doc = await conversationRef.get();

    if (!doc.exists) {
      await conversationRef.set({
        'id': conversationId,
        'participantIds': participantIds,
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessage': '',
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });
    }

    return conversationId;
  }

  /// Get user conversations
  Stream<List<Map<String, dynamic>>> getUserConversationsStream(
    String userId,
  ) {
    return _firestore
        .collection(AppConstants.conversationsCollection)
        .where('participantIds', arrayContains: userId)
        .orderBy('lastMessageTimestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}
