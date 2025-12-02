// lib/presentation/screens/map_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';
import 'add_activity_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? position;
  CameraController? cameraController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEverything();
  }

  Future<void> _loadEverything() async {
    await _getLocation();
    await _initCamera();
    if (mounted) setState(() => isLoading = false);
  }

  // ------------------------------
  // GET USER LOCATION
  // ------------------------------
  Future<void> _getLocation() async {
    try {
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enable Location")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      // Fallback coordinates (Islamabad)
      position = Position(
        latitude: 33.6844,
        longitude: 73.0479,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }
  }

  // ------------------------------
  // INITIALIZE CAMERA
  // ------------------------------
  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      cameraController =
          CameraController(cameras.first, ResolutionPreset.medium);
      await cameraController!.initialize();
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  // ------------------------------
  // UI
  // ------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: isLoading || position == null
          ? const Center(
        child: CircularProgressIndicator(color: Colors.deepPurple),
      )
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(position!.latitude, position!.longitude),
          zoom: 17,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId("current"),
            position: LatLng(position!.latitude, position!.longitude),
            infoWindow: const InfoWindow(title: "You are here"),
          )
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (cameraController == null || !cameraController!.value.isInitialized) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Camera not ready yet")),
            );
            return;
          }

          final picture = await cameraController!.takePicture();
          final bytes = await picture.readAsBytes();
          final base64Image = base64Encode(bytes);

          if (!mounted) return;
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
    cameraController?.dispose();
    super.dispose();
  }
}
