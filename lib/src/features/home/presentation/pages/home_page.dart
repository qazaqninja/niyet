import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_paths.dart';
import '../../../niyet/presentation/bloc/niyet_bloc.dart';
import '../../../niyet/presentation/widgets/niyet_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NiyetBloc>().add(const NiyetLoadRequested());
  }

  bool get _isMorning {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 17;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Niyet'),
        centerTitle: false,
      ),
      body: BlocBuilder<NiyetBloc, NiyetState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              // Greeting section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isMorning ? 'Good morning' : 'Good evening',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isMorning
                            ? 'Set your intentions for today'
                            : 'Time for reflection',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quick actions
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionCard(
                          icon: Icons.add_circle_outline,
                          label: 'Set Intention',
                          onTap: () => context.push(RoutePaths.setNiyet),
                          isPrimary: _isMorning,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ActionCard(
                          icon: Icons.nightlight_outlined,
                          label: 'Reflect',
                          onTap: () => context.push(RoutePaths.muhasaba),
                          isPrimary: !_isMorning,
                          badge: state.niyetler
                                  .where((n) => !n.isReflected)
                                  .length
                                  .toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Today's intentions header
              if (state.niyetler.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
                    child: Row(
                      children: [
                        Text(
                          "Today's Intentions",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Text(
                          '${state.reflectedCount}/${state.todayCount}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Niyetler list
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final niyet = state.niyetler[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: NiyetCard(
                            niyet: niyet,
                            onTap: niyet.isReflected
                                ? null
                                : () => context.push(RoutePaths.muhasaba),
                          ),
                        );
                      },
                      childCount: state.niyetler.length,
                    ),
                  ),
                ),
              ],

              // Empty state
              if (state.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 64,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No intentions yet',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Set your first intention for today',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () => context.push(RoutePaths.setNiyet),
                            icon: const Icon(Icons.add),
                            label: const Text('Set Intention'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
    this.badge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPrimary ? Theme.of(context).colorScheme.primary : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: isPrimary
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                  ),
                  if (badge != null && badge != '0') ...[
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isPrimary
                            ? Colors.white.withValues(alpha: 0.2)
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        badge!,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isPrimary
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isPrimary ? Colors.white : null,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
