import 'package:equatable/equatable.dart';

enum DeliveryStatus {
  picked,
  enRoute,
  arriving,
  delivered,
}

class DriverLocation extends Equatable {
  final double lat;
  final double lng;
  final double speed;
  final double heading;
  final DeliveryStatus status;
  final int timestamp;

  const DriverLocation({
    required this.lat,
    required this.lng,
    required this.speed,
    required this.heading,
    required this.status,
    required this.timestamp,
  });

  @override
  List<Object> get props => [lat, lng, speed, heading, status, timestamp];
}

