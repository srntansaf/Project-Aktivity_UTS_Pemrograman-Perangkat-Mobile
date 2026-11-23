import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  Future<void> _openForm(BuildContext context, {ActivityModel? activity}) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityFormView(
          viewModel: viewModel,
          activity: activity,
        ),
      ),
    );
    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(activity == null
              ? 'Aktivitas berhasil ditambahkan.'
              : 'Aktivitas berhasil diperbarui.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ActivityTrack',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text('Catat progres aktivitas harianmu',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, _) {
          final activities = viewModel.activities;
          final total = activities.fold<int>(0, (sum, item) => sum + item.counter);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6750A4), Color(0xFF9279D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Aktivitas kamu',
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 8),
                          Text('${activities.length} aktivitas',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('$total total pencapaian tercatat',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    const Icon(Icons.insights_rounded,
                        size: 54, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Daftar Aktivitas',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  Text('${activities.length} item',
                      style: const TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 12),
              if (activities.isEmpty)
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.inbox_rounded, size: 46, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('Belum ada aktivitas',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Tekan tombol + untuk membuat aktivitas baru.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                )
              else
                ...activities.map((activity) => _ActivityCard(
                      activity: activity,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ActivityDetailView(
                            viewModel: viewModel,
                            activityId: activity.id,
                          ),
                        ),
                      ),
                      onEdit: () => _openForm(context, activity: activity),
                    )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Aktivitas'),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const _ActivityCard({
    required this.activity,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.track_changes_rounded,
                    color: Color(0xFF6750A4)),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text('Counter: ${activity.counter}',
                        style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Edit aktivitas',
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
              ),
              const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}
