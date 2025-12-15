import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}
class ChatLoaded extends ChatState {}
class ChatError extends ChatState {
  const ChatError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
