import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatLoadRequested>(_onChatLoadRequested);
  }

  final ChatRepository chatRepository;

  Future<void> _onChatLoadRequested(
    ChatLoadRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    emit(ChatLoaded());
  }
}
