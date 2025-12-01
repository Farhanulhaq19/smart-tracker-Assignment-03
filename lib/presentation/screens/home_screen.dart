import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SmartTracker"), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.track_changes, size: 100, color: Colors.deepPurple),
        const Text("SmartTracker", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 50),
        ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())), icon: const Icon(Icons.location_on), label: const Text("Start Tracking", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20))),
        const SizedBox(height: 20),
        ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())), icon: const Icon(Icons.history), label: const Text("View History", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20))),
      ])),
    );
  }
}
