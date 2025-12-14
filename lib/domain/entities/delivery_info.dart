import 'package:equatable/equatable.dart';
import 'driver_location.dart';

class DeliveryInfo extends Equatable {
  final DriverLocation driverLocation;
  final double destinationLat;
  final double destinationLng;
  final String driverName;
  final String driverPhone;
  final String vehicleNumber;
  final double distance;
  final String eta;
  final DateTime lastUpdated;

  const DeliveryInfo({
    required this.driverLocation,
    required this.destinationLat,
    required this.destinationLng,
    required this.driverName,
    required this.driverPhone,
    required this.vehicleNumber,
    required this.distance,
    required this.eta,
    required this.lastUpdated,
  });

  @override
  List<Object> get props => [
        driverLocation,
        destinationLat,
        destinationLng,
        driverName,
        driverPhone,
        vehicleNumber,
        distance,
        eta,
        lastUpdated,
      ];
}

