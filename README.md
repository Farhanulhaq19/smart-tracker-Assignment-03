SmartTracker – Flutter Mobile Application

Course: Mobile Application Development (CS4723)
Program: BSSE – Semester V, Riphah International University, Islamabad
Assignment: #3 – Complex Computing Problem (CCP)

Author: Farhanul Haq

Table of Contents

Overview

Features

Folder Structure

Prerequisites

Setup & Installation

Google Maps API Key Setup

Running the App

API Endpoints

Testing

Contributors

License

Overview

SmartTracker is a cross-platform Flutter application that:

Tracks live location using GPS

Captures photos using device camera

Logs activities (location + image + timestamp + address)

Syncs logs with a REST API backend

Provides offline caching for the last 5 activities

Displays a history dashboard with search and delete options

The app follows clean architecture:

UI (Flutter Screens) → Provider (State Management) → Node.js REST API → Local Storage (Hive / SharedPreferences)

Features

Live Google Maps with current location

Capture activity images using Camera

Add, view, and delete activity logs

Offline storage for recent activities

API integration with GET/POST endpoints

Responsive UI for Android devices

Folder Structure
smart_tracker/
│
├─ android/                  # Android platform-specific files
├─ ios/                      # iOS platform-specific files
├─ lib/
│   ├─ domain/
│   │   └─ entities/
│   │       └─ activity.dart
│   ├─ presentation/
│   │   └─ screens/
│   │       ├─ map_screen.dart
│   │       └─ add_activity_screen.dart
│   ├─ providers/
│   │   └─ activity_provider.dart
│   ├─ services/
│   │   └─ api_service.dart
│   └─ main.dart
├─ test/                     # Unit & widget tests
├─ server.js                  # Node.js REST API
├─ pubspec.yaml               # Flutter dependencies
└─ README.md

Prerequisites

Flutter SDK (>=3.0)

Android Studio (with Flutter & Dart plugins)

Node.js (>=18.x) & npm

Google Maps API Key

Terminal / PowerShell for running server & Flutter app

Setup & Installation
1. Clone Repository
git clone <your-github-repo-link>
cd smart_tracker

2. Install Flutter Dependencies
flutter pub get

3. Setup Node.js Backend
npm install express
node server.js


Server runs on: http://localhost:3000

Endpoints:

GET /activities → fetch all activities

POST /activities → add a new activity

Google Maps API Key Setup

Go to Google Cloud Console
 → APIs & Services → Credentials

Create an API key for Maps SDK for Android

Enable Maps SDK for Android & Places API

Add the API key to android/app/src/main/AndroidManifest.xml:

<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_API_KEY_HERE"/>


Replace YOUR_API_KEY_HERE with your key

Running the App in Android Studio

Open Android Studio → File → Open → select smart_tracker folder

Connect Android device or launch emulator

Run main.dart

Grant location and camera permissions on first launch

Test app features: Map, Capture Activity, View Dashboard

API Endpoints

GET Activities:

Invoke-RestMethod -Uri http://localhost:3000/activities -Method Get


POST Activity:

Invoke-RestMethod -Uri http://localhost:3000/activities -Method Post -Body (@{
    latitude = 33.6844
    longitude = 73.0479
    imageBase64 = "test123"
    timestamp = "2025-12-02T12:00:00"
    address = "Current Location"
} | ConvertTo-Json) -ContentType "application/json"

Testing

Verify GET /activities returns empty or existing logs

Verify POST /activities adds a new activity and prints in Node.js terminal

Offline caching tested via last 5 activities

UI tested on Android device/emulator
Screenshots are added in Folder 

Contributors

Farhanul Haq – BSSE, Riphah International University, Islamabad

License

Academic project – not intended for commercial use
