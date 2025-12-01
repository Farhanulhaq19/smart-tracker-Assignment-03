class ActivityModel {
  final String? id;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String timestamp;
  final String address;

  ActivityModel({this.id, required this.latitude, required this.longitude, required this.imageUrl, required this.timestamp, required this.address});

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id']?.toString(),
        latitude: double.parse(json['latitude'].toString()),
        longitude: double.parse(json['longitude'].toString()),
        imageUrl: json['imageUrl'],
        timestamp: json['timestamp'],
        address: json['address'] ?? 'Unknown',
      );

  Map<String, dynamic> toJson() => {"latitude": latitude, "longitude": longitude, "imageUrl": imageUrl, "timestamp": timestamp, "address": address};
}
