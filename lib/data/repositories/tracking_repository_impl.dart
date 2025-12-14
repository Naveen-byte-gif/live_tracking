import 'dart:async';
import '../../domain/entities/driver_location.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../datasources/mock_location_service.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final MockLocationService _locationService;

  TrackingRepositoryImpl(this._locationService);

  @override
  Stream<DriverLocation> startTracking() {
    return _locationService.startTracking();
  }

  @override
  void stopTracking() {
    _locationService.stopTracking();
  }

  @override
  bool get isTracking => _locationService.isTracking;
}

