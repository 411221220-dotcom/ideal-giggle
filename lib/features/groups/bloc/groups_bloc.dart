import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/group_repository.dart';
import 'groups_event.dart';
import 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc({required this.groupRepository}) : super(GroupsInitial()) {
    on<GroupsLoadRequested>(_onGroupsLoadRequested);
    on<GroupsRefreshRequested>(_onGroupsRefreshRequested);
  }

  final GroupRepository groupRepository;

  Future<void> _onGroupsLoadRequested(
    GroupsLoadRequested event,
    Emitter<GroupsState> emit,
  ) async {
    emit(GroupsLoading());
    try {
      final groups = await groupRepository.getGroups();
      emit(GroupsLoaded(groups: groups));
    } catch (e) {
      emit(GroupsError(message: e.toString()));
    }
  }

  Future<void> _onGroupsRefreshRequested(
    GroupsRefreshRequested event,
    Emitter<GroupsState> emit,
  ) async {
    try {
      final groups = await groupRepository.getGroups();
      emit(GroupsLoaded(groups: groups));
    } catch (e) {
      emit(GroupsError(message: e.toString()));
    }
  }
}
