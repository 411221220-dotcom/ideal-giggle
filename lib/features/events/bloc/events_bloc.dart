import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/event_repository.dart';
import 'events_event.dart';
import 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({required this.eventRepository}) : super(EventsInitial()) {
    on<EventsLoadRequested>(_onEventsLoadRequested);
    on<EventsRefreshRequested>(_onEventsRefreshRequested);
  }

  final EventRepository eventRepository;

  Future<void> _onEventsLoadRequested(
    EventsLoadRequested event,
    Emitter<EventsState> emit,
  ) async {
    emit(EventsLoading());
    try {
      final events = await eventRepository.getUpcomingEvents();
      emit(EventsLoaded(events: events));
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }

  Future<void> _onEventsRefreshRequested(
    EventsRefreshRequested event,
    Emitter<EventsState> emit,
  ) async {
    try {
      final events = await eventRepository.getUpcomingEvents();
      emit(EventsLoaded(events: events));
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }
}
