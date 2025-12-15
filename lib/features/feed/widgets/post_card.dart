import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/theme/app_colors.dart';

/// Widget to display a single post
class PostCard extends StatelessWidget {
  const PostCard({required this.post, super.key});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(Helpers.getInitials(post.authorName)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        Helpers.getRelativeTime(post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Content
            Text(post.content),
            // Actions
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.favorite_border, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${post.likesCount}'),
                const SizedBox(width: 16),
                Icon(Icons.comment_outlined, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${post.commentsCount}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
