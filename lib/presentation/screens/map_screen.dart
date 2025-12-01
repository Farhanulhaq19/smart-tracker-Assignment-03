// lib/presentation/screens/map_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import 'add_activity_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? position;
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initCamera();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enable location service")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: position == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 18,
        ),
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("me"),
            position: LatLng(position!.latitude, position!.longitude),
            infoWindow: const InfoWindow(title: "You are here"),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (!cameraController.value.isInitialized) return;

          final xFile = await cameraController.takePicture();
          final bytes = await xFile.readAsBytes();
          final base64Image = base64Encode(bytes);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddActivityScreen(
                latitude: position!.latitude,
                longitude: position!.longitude,
                imageBase64: base64Image,
                address: "Current Location",
              ),
            ),
          );
        },
        label: const Text("Capture Activity"),
        icon: const Icon(Icons.camera_alt),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}