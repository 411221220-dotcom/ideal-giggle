import 'package:equatable/equatable.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
  @override
  List<Object?> get props => [];
}

class GroupsLoadRequested extends GroupsEvent {}
class GroupsRefreshRequested extends GroupsEvent {}
