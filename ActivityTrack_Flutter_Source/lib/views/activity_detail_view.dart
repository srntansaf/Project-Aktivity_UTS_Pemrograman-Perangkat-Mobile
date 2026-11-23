import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final String activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  Future<void> _reset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset counter?'),
        content: const Text(
            'Nilai counter aktivitas ini akan dikembalikan menjadi 0. Lanjutkan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.resetCounter(activityId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Counter berhasil di-reset.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus aktivitas?'),
        content: const Text(
            'Aktivitas ini akan dihapus dari daftar. Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      viewModel.deleteActivity(activityId);
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aktivitas berhasil dihapus.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final activity = viewModel.getActivity(activityId);
        if (activity == null) {
          return const Scaffold(
            body: Center(child: Text('Aktivitas tidak ditemukan.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Aktivitas'),
            actions: [
              IconButton(
                tooltip: 'Edit aktivitas',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivityFormView(
                        viewModel: viewModel,
                        activity: activity,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 22),
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.track_changes_rounded,
                      size: 40, color: Color(0xFF6750A4)),
                ),
                const SizedBox(height: 18),
                Text(activity.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Jumlah aktivitas yang sudah tercatat',
                    style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      Text('${activity.counter}',
                          style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6750A4))),
                      const Text('TOTAL COUNTER',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 11,
                              color: Colors.black54)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: activity.counter > 0
                            ? () {
                                viewModel.decrementCounter(activityId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Counter dikurangi 1.'),
                                    duration: Duration(milliseconds: 900),
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                        label: const Text('Kurang'),
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 52)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          viewModel.incrementCounter(activityId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Counter bertambah 1.'),
                              duration: Duration(milliseconds: 900),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah'),
                        style: FilledButton.styleFrom(
                            minimumSize: const Size(0, 52)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _reset(context),
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset Counter'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => _delete(context),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text('Hapus Aktivitas',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
