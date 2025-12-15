import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'core/services/firebase_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/post_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/repositories/group_repository.dart';
import 'data/repositories/chat_repository.dart';
import 'features/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Firebase Service
  final firebaseService = FirebaseService();
  await firebaseService.initialize();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style for dark theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0f0f1a),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Initialize repositories
  final authRepository = AuthRepository();
  final postRepository = PostRepository();
  final eventRepository = EventRepository();
  final groupRepository = GroupRepository();
  final chatRepository = ChatRepository();
  
  runApp(
    StargazingApp(
      authRepository: authRepository,
      postRepository: postRepository,
      eventRepository: eventRepository,
      groupRepository: groupRepository,
      chatRepository: chatRepository,
    ),
  );
}
