
import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository);

  List<ActivityModel> get activities => _repository.getAllActivities;

  ActivityModel? getActivity(String id) => _repository.getActivityById(id);

  void addActivity(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return;

    _repository.addActivity(ActivityModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: trimmedName,
    ));
    notifyListeners();
  }

  void updateActivity(String id, String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return;
    _repository.updateActivity(id, trimmedName);
    notifyListeners();
  }

  void deleteActivity(String id) {
    _repository.deleteActivity(id);
    notifyListeners();
  }

  void incrementCounter(String id) {
    final activity = getActivity(id);
    if (activity == null) return;
    _repository.updateCounter(id, activity.counter + 1);
    notifyListeners();
  }

  void decrementCounter(String id) {
    final activity = getActivity(id);
    if (activity == null || activity.counter <= 0) return;
    _repository.updateCounter(id, activity.counter - 1);
    notifyListeners();
  }

  void resetCounter(String id) {
    if (getActivity(id) == null) return;
    _repository.updateCounter(id, 0);
    notifyListeners();
  }
}
