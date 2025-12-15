import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../shared/widgets/error_widget.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/post_card.dart';

/// Feed screen displaying posts from the community
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(
        postRepository: context.read<PostRepository>(),
      )..add(FeedLoadRequested()),
      child: const FeedView(),
    );
  }
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined),
            onPressed: () {
              // Navigate to create post
            },
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const CustomLoadingIndicator();
          }

          if (state is FeedError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<FeedBloc>().add(FeedLoadRequested()),
            );
          }

          if (state is FeedLoaded) {
            if (state.posts.isEmpty) {
              return const EmptyStateWidget(
                message: 'No posts yet. Be the first to share!',
                icon: Icons.photo_library_outlined,
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FeedBloc>().add(FeedRefreshRequested());
              },
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: state.posts[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
