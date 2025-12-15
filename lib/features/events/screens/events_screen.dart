import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/event_repository.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../shared/widgets/error_widget.dart';
import '../bloc/events_bloc.dart';
import '../bloc/events_event.dart';
import '../bloc/events_state.dart';
import '../widgets/event_card.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsBloc(
        eventRepository: context.read<EventRepository>(),
      )..add(EventsLoadRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Events')),
        body: BlocBuilder<EventsBloc, EventsState>(
          builder: (context, state) {
            if (state is EventsLoading) return const CustomLoadingIndicator();
            if (state is EventsError) {
              return CustomErrorWidget(
                message: state.message,
                onRetry: () => context.read<EventsBloc>().add(EventsLoadRequested()),
              );
            }
            if (state is EventsLoaded) {
              if (state.events.isEmpty) {
                return const EmptyStateWidget(
                  message: 'No upcoming events',
                  icon: Icons.event_outlined,
                );
              }
              return ListView.builder(
                itemCount: state.events.length,
                itemBuilder: (context, index) => EventCard(event: state.events[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
