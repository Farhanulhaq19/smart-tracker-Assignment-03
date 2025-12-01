import 'package:flutter/material.dart';
import '../../domain/entities/activity.dart';
import '../../data/repositories/activity_repository_impl.dart';

class ActivityProvider extends ChangeNotifier {
  final repo = ActivityRepositoryImpl();
  List<Activity> activities = [];
  List<Activity> offlineActivities = [];
  bool isLoading = false;

  ActivityProvider() { loadActivities(); }

  Future<void> loadActivities() async {
    isLoading = true; notifyListeners();
    activities = await repo.getActivitiesFromApi();
    offlineActivities = await repo.local.getOffline();
    isLoading = false; notifyListeners();
  }

  Future<void> addActivity(Activity activity) async { await repo.saveActivity(activity); await loadActivities(); }
  Future<void> deleteActivity(String id) async { await repo.deleteActivity(id); await loadActivities(); }
}
