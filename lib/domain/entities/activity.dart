class Activity {
  final String? id;
  final double latitude;
  final double longitude;
  final String imageBase64;
  final DateTime timestamp;
  final String address;

  Activity({this.id, required this.latitude, required this.longitude, required this.imageBase64, required this.timestamp, required this.address});

  Map<String, dynamic> toMap() => {'id': id, 'latitude': latitude, 'longitude': longitude, 'imageBase64': imageBase64, 'timestamp': timestamp.toIso8601String(), 'address': address};

  factory Activity.fromMap(Map map) => Activity(
        id: map['id'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        imageBase64: map['imageBase64'],
        timestamp: DateTime.parse(map['timestamp']),
        address: map['address'],
      );
}
