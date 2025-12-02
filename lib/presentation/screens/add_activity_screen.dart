// lib/presentation/screens/add_activity_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/activity.dart';
import '../providers/activity_provider.dart';

class AddActivityScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String imageBase64;
  final String address;

  const AddActivityScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.imageBase64,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final imageBytes = Base64Decoder().convert(imageBase64);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Activity"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.memory(
              imageBytes,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            ListTile(title: Text("Latitude: ${latitude.toStringAsFixed(6)}")),
            ListTile(title: Text("Longitude: ${longitude.toStringAsFixed(6)}")),
            ListTile(title: Text("Time: ${DateTime.now().toString().substring(0, 19)}")),
            ListTile(title: Text("Address: $address")),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final activity = Activity(
                  latitude: latitude,
                  longitude: longitude,
                  imageBase64: imageBase64,
                  timestamp: DateTime.now(),
                  address: address,
                );

                Provider.of<ActivityProvider>(context, listen: false)
                    .addActivity(activity);

                Navigator.popUntil(context, (route) => route.isFirst);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Activity Saved Successfully!"),
                  ),
                );
              },
              child: const Text("Save Activity"),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
