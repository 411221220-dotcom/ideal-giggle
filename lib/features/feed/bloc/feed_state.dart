import 'package:equatable/equatable.dart';
import '../../../data/models/post_model.dart';

/// States for feed
abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class FeedInitial extends FeedState {}

/// Loading state
class FeedLoading extends FeedState {}

/// Loaded state
class FeedLoaded extends FeedState {
  const FeedLoaded({required this.posts});

  final List<PostModel> posts;

  @override
  List<Object?> get props => [posts];
}

/// Error state
class FeedError extends FeedState {
  const FeedError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
