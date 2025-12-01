import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override Widget build(BuildContext context) {
    final p = Provider.of<ActivityProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: p.isLoading ? const Center(child: CircularProgressIndicator()) : p.activities.isEmpty ? const Center(child: Text("No data")) :
      ListView.builder(itemCount: p.activities.length, itemBuilder: (c, i) {
        final a = p.activities[i];
        return Card(child: ListTile(
          leading: Image.memory(base64Decode(a.imageBase64), width: 60, height: 60, fit: BoxFit.cover),
          title: Text("${a.latitude.toStringAsFixed(4)}, ${a.longitude.toStringAsFixed(4)}"),
          subtitle: Text(a.timestamp.toString().substring(0,16)),
          trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => p.deleteActivity(a.id ?? "")),
        ));
      }),
    );
  }
}
