import 'package:hive/hive.dart'; import '../../domain/entities/activity.dart';
class LocalDataSource {
  static const boxName = 'activities';
  Future<void> saveOffline(Activity activity) async {
    final box = Hive.box(boxName);
    await box.add(activity.toMap());
    if (box.length > 5) await box.deleteAt(0);
  }
  Future<List<Activity>> getOffline() async {
    final box = Hive.box(boxName);
    return box.values.map((e) => Activity.fromMap(e as Map)).toList().reversed.toList();
  }
}
