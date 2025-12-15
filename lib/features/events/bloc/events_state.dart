import 'package:equatable/equatable.dart';
import '../../../data/models/event_model.dart';

abstract class EventsState extends Equatable {
  const EventsState();
  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}
class EventsLoading extends EventsState {}
class EventsLoaded extends EventsState {
  const EventsLoaded({required this.events});
  final List<EventModel> events;
  @override
  List<Object?> get props => [events];
}
class EventsError extends EventsState {
  const EventsError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
