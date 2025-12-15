import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/post_repository.dart';
import '../data/repositories/event_repository.dart';
import '../data/repositories/group_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../features/auth/bloc/auth_bloc.dart';
import 'routes.dart';

/// The main application widget for Stargazing Social Community
class StargazingApp extends StatelessWidget {
  const StargazingApp({
    required this.authRepository,
    required this.postRepository,
    required this.eventRepository,
    required this.groupRepository,
    required this.chatRepository,
    super.key,
  });

  final AuthRepository authRepository;
  final PostRepository postRepository;
  final EventRepository eventRepository;
  final GroupRepository groupRepository;
  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: postRepository),
        RepositoryProvider.value(value: eventRepository),
        RepositoryProvider.value(value: groupRepository),
        RepositoryProvider.value(value: chatRepository),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository)
          ..add(AuthCheckRequested()),
        child: Builder(
          builder: (context) {
            final router = createRouter(context);
            
            return MaterialApp.router(
              title: 'Stargazing Social',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
