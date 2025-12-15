import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/bloc/auth_state.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/feed/screens/feed_screen.dart';
import '../features/feed/screens/create_post_screen.dart';
import '../features/events/screens/events_screen.dart';
import '../features/events/screens/event_detail_screen.dart';
import '../features/events/screens/create_event_screen.dart';
import '../features/groups/screens/groups_screen.dart';
import '../features/groups/screens/group_detail_screen.dart';
import '../features/groups/screens/create_group_screen.dart';
import '../features/chat/screens/conversations_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../shared/widgets/bottom_nav_bar.dart';

/// Create and configure app router
GoRouter createRouter(BuildContext context) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';

      // If user is authenticated and trying to access login routes, redirect to feed
      if (isAuthenticated && isLoginRoute) {
        return '/feed';
      }

      // If user is not authenticated and trying to access protected routes, redirect to login
      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }

      return null; // No redirect needed
    },
    routes: [
      // Authentication Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main App Routes with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavScaffold(child: child);
        },
        routes: [
          // Feed Routes
          GoRoute(
            path: '/feed',
            builder: (context, state) => const FeedScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreatePostScreen(),
              ),
            ],
          ),

          // Events Routes
          GoRoute(
            path: '/events',
            builder: (context, state) => const EventsScreen(),
            routes: [
              GoRoute(
                path: ':eventId',
                builder: (context, state) {
                  final eventId = state.pathParameters['eventId']!;
                  return EventDetailScreen(eventId: eventId);
                },
              ),
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateEventScreen(),
              ),
            ],
          ),

          // Groups Routes
          GoRoute(
            path: '/groups',
            builder: (context, state) => const GroupsScreen(),
            routes: [
              GoRoute(
                path: ':groupId',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  return GroupDetailScreen(groupId: groupId);
                },
              ),
              GoRoute(
                path: 'create',
                builder: (context, state) => const CreateGroupScreen(),
              ),
            ],
          ),

          // Chat Routes
          GoRoute(
            path: '/chat',
            builder: (context, state) => const ConversationsScreen(),
            routes: [
              GoRoute(
                path: ':conversationId',
                builder: (context, state) {
                  final conversationId = state.pathParameters['conversationId']!;
                  return ChatScreen(conversationId: conversationId);
                },
              ),
            ],
          ),

          // Profile Routes
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) => const EditProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Scaffold with bottom navigation bar
class BottomNavScaffold extends StatelessWidget {
  const BottomNavScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
