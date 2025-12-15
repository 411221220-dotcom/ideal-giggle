import 'package:equatable/equatable.dart';
import '../../../data/models/group_model.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();
  @override
  List<Object?> get props => [];
}

class GroupsInitial extends GroupsState {}
class GroupsLoading extends GroupsState {}
class GroupsLoaded extends GroupsState {
  const GroupsLoaded({required this.groups});
  final List<GroupModel> groups;
  @override
  List<Object?> get props => [groups];
}
class GroupsError extends GroupsState {
  const GroupsError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
