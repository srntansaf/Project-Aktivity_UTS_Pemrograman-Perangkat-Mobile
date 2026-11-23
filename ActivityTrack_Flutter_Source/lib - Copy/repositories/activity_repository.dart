import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _data;

  ActivityRepository(this._data);

  List<ActivityModel> getAllActivities =>
      List.unmodifiable(_data.activities);

  ActivityModel? getActivityById(String id) {
    try {
      return _data.activities.firstWhere((activity) => activity.id == id);
    } catch (_) {
      return null;
    }
  }

  void addActivity(ActivityModel activity) {
    _data.activities.add(activity);
  }

  void updateActivity(String id, String newName) {
    final index = _data.activities.indexWhere((item) => item.id == id);
    if (index != -1) {
      _data.activities[index] =
          _data.activities[index].copyWith(name: newName);
    }
  }

  void deleteActivity(String id) {
    _data.activities.removeWhere((item) => item.id == id);
  }

  void updateCounter(String id, int newValue) {
    final index = _data.activities.indexWhere((item) => item.id == id);
    if (index != -1) {
      _data.activities[index] =
          _data.activities[index].copyWith(counter: newValue);
    }
  }
}
