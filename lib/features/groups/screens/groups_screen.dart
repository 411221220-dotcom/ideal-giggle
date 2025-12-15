import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../shared/widgets/error_widget.dart';
import '../bloc/groups_bloc.dart';
import '../bloc/groups_event.dart';
import '../bloc/groups_state.dart';
import '../widgets/group_card.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsBloc(
        groupRepository: context.read<GroupRepository>(),
      )..add(GroupsLoadRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Groups')),
        body: BlocBuilder<GroupsBloc, GroupsState>(
          builder: (context, state) {
            if (state is GroupsLoading) return const CustomLoadingIndicator();
            if (state is GroupsError) {
              return CustomErrorWidget(
                message: state.message,
                onRetry: () => context.read<GroupsBloc>().add(GroupsLoadRequested()),
              );
            }
            if (state is GroupsLoaded) {
              if (state.groups.isEmpty) {
                return const EmptyStateWidget(
                  message: 'No groups yet',
                  icon: Icons.groups_outlined,
                );
              }
              return ListView.builder(
                itemCount: state.groups.length,
                itemBuilder: (context, index) => GroupCard(group: state.groups[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
