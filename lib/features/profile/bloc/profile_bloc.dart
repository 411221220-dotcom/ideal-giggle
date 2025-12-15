import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
  }

  final AuthRepository authRepository;

  Future<void> _onProfileLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      if (authRepository.currentUser != null) {
        final user = await authRepository.getUserData(
          authRepository.currentUser!.uid,
        );
        emit(ProfileLoaded(user: user));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
