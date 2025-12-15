import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/post_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

/// BLoC for feed management
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.postRepository}) : super(FeedInitial()) {
    on<FeedLoadRequested>(_onFeedLoadRequested);
    on<FeedRefreshRequested>(_onFeedRefreshRequested);
    on<FeedLikePost>(_onFeedLikePost);
    on<FeedUnlikePost>(_onFeedUnlikePost);
  }

  final PostRepository postRepository;

  Future<void> _onFeedLoadRequested(
    FeedLoadRequested event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    
    try {
      final posts = await postRepository.getPosts();
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  Future<void> _onFeedRefreshRequested(
    FeedRefreshRequested event,
    Emitter<FeedState> emit,
  ) async {
    try {
      final posts = await postRepository.getPosts();
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  Future<void> _onFeedLikePost(
    FeedLikePost event,
    Emitter<FeedState> emit,
  ) async {
    try {
      // TODO: Implement like functionality
      // await postRepository.likePost(event.postId, currentUserId);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onFeedUnlikePost(
    FeedUnlikePost event,
    Emitter<FeedState> emit,
  ) async {
    try {
      // TODO: Implement unlike functionality
      // await postRepository.unlikePost(event.postId, currentUserId);
    } catch (e) {
      // Handle error
    }
  }
}
