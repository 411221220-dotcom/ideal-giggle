import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
  @override
  List<Object?> get props => [];
}

class EventsLoadRequested extends EventsEvent {}
class EventsRefreshRequested extends EventsEvent {}
