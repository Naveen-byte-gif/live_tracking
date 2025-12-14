import 'dart:async';
import '../entities/driver_location.dart';

abstract class TrackingRepository {
  Stream<DriverLocation> startTracking();
  void stopTracking();
  bool get isTracking;
}

