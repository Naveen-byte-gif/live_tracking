import '../../domain/entities/driver_location.dart';

class DriverLocationModel extends DriverLocation {
  const DriverLocationModel({
    required super.lat,
    required super.lng,
    required super.speed,
    required super.heading,
    required super.status,
    required super.timestamp,
  });

  factory DriverLocationModel.fromJson(Map<String, dynamic> json) {
    return DriverLocationModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      heading: (json['heading'] as num).toDouble(),
      status: _parseStatus(json['status'] as String),
      timestamp: json['timestamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'speed': speed,
      'heading': heading,
      'status': _statusToString(status),
      'timestamp': timestamp,
    };
  }

  static DeliveryStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'picked':
        return DeliveryStatus.picked;
      case 'en_route':
      case 'enroute':
        return DeliveryStatus.enRoute;
      case 'arriving':
        return DeliveryStatus.arriving;
      case 'delivered':
        return DeliveryStatus.delivered;
      default:
        return DeliveryStatus.enRoute;
    }
  }

  static String _statusToString(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.picked:
        return 'picked';
      case DeliveryStatus.enRoute:
        return 'en_route';
      case DeliveryStatus.arriving:
        return 'arriving';
      case DeliveryStatus.delivered:
        return 'delivered';
    }
  }
}

