import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class MapState extends Equatable {
  final LatLng driverPosition;
  final double driverHeading;
  final LatLng cameraCenter;
  final double cameraZoom;
  final bool isInitialized;

  const MapState({
    required this.driverPosition,
    required this.driverHeading,
    required this.cameraCenter,
    required this.cameraZoom,
    required this.isInitialized,
  });

  MapState copyWith({
    LatLng? driverPosition,
    double? driverHeading,
    LatLng? cameraCenter,
    double? cameraZoom,
    bool? isInitialized,
  }) {
    return MapState(
      driverPosition: driverPosition ?? this.driverPosition,
      driverHeading: driverHeading ?? this.driverHeading,
      cameraCenter: cameraCenter ?? this.cameraCenter,
      cameraZoom: cameraZoom ?? this.cameraZoom,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object> get props => [
        driverPosition,
        driverHeading,
        cameraCenter,
        cameraZoom,
        isInitialized,
      ];
}

