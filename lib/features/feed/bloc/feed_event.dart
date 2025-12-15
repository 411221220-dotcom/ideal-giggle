import 'package:equatable/equatable.dart';

/// Events for feed
abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

/// Load posts
class FeedLoadRequested extends FeedEvent {}

/// Refresh posts
class FeedRefreshRequested extends FeedEvent {}

/// Like post
class FeedLikePost extends FeedEvent {
  const FeedLikePost({required this.postId});

  final String postId;

  @override
  List<Object?> get props => [postId];
}

/// Unlike post
class FeedUnlikePost extends FeedEvent {
  const FeedUnlikePost({required this.postId});

  final String postId;

  @override
  List<Object?> get props => [postId];
}
