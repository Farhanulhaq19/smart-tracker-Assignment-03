import 'dart:convert'; import 'package:http/http.dart' as http; import '../models/activity_model.dart';
class RemoteDataSource {
  final String baseUrl = "https://6717c0aab910c4e0f7ed7208.mockapi.io/api/v1/activities";
  Future<List<ActivityModel>> getActivities() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) return (json.decode(response.body) as List).map((e) => ActivityModel.fromJson(e)).toList();
    throw Exception("Failed");
  }
  Future<ActivityModel> addActivity(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse(baseUrl), body: data);
    if (response.statusCode == 201) return ActivityModel.fromJson(json.decode(response.body));
    throw Exception("Failed");
  }
  Future<void> deleteActivity(String id) async => await http.delete(Uri.parse("$baseUrl/$id"));
}
