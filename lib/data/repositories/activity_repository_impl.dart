import 'package:connectivity_plus/connectivity_plus.dart';
import '../datasources/remote_datasource.dart';
import '../datasources/local_datasource.dart';
import '../../domain/entities/activity.dart';

class ActivityRepositoryImpl {
  final remote = RemoteDataSource();
  final local = LocalDataSource();

  Future<List<Activity>> getActivitiesFromApi() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return local.getOffline();
    try {
      final data = await remote.getActivities();
      return data.map((e) => Activity(id: e.id, latitude: e.latitude, longitude: e.longitude, imageBase64: e.imageUrl, timestamp: DateTime.parse(e.timestamp), address: e.address)).toList();
    } catch (e) { return local.getOffline(); }
  }

  Future<void> saveActivity(Activity activity) async {
    await local.saveOffline(activity);
    try { await remote.addActivity({"latitude": activity.latitude.toString(), "longitude": activity.longitude.toString(), "imageUrl": activity.imageBase64, "timestamp": activity.timestamp.toIso8601String(), "address": activity.address}); }
    catch (e) { print("Offline only"); }
  }

  Future<void> deleteActivity(String id) async => await remote.deleteActivity(id);
}
