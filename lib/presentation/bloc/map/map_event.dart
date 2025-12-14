import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class UpdateDriverPositionEvent extends MapEvent {
  final LatLng position;
  final double heading;

  const UpdateDriverPositionEvent({
    required this.position,
    required this.heading,
  });

  @override
  List<Object> get props => [position, heading];
}

class UpdateCameraEvent extends MapEvent {
  final LatLng center;
  final double zoom;

  const UpdateCameraEvent({
    required this.center,
    required this.zoom,
  });

  @override
  List<Object> get props => [center, zoom];
}

class ResetMapEvent extends MapEvent {
  const ResetMapEvent();
}

