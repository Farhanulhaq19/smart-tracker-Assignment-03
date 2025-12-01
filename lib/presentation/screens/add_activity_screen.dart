import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/activity.dart';
import '../providers/activity_provider.dart';

class AddActivityScreen extends StatelessWidget {
  final double latitude; final double longitude; final String imageBase64; final String address;
  const AddActivityScreen({super.key, required this.latitude, required this.longitude, required this.imageBase64, required this.address});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Save Activity")),
      body: Column(children: [
        Image.memory(base64Decode(imageBase64), height: 300, width: double.infinity, fit: BoxFit.cover),
        ListTile(title: Text("Lat: ${latitude.toStringAsFixed(6)}")),
        ListTile(title: Text("Lng: ${longitude.toStringAsFixed(6)}")),
        ListTile(title: Text("Time: ${DateTime.now()}")),
        ElevatedButton(onPressed: () {
          Provider.of<ActivityProvider>(context, listen: false).addActivity(Activity(latitude: latitude, longitude: longitude, imageBase64: imageBase64, timestamp: DateTime.now(), address: address));
          Navigator.popUntil(context, (r) => r.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved!")));
        }, child: const Text("Save Activity"))
      ]),
    );
  }
}
