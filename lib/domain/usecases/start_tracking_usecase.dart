import 'dart:async';
import '../entities/driver_location.dart';
import '../repositories/tracking_repository.dart';

class StartTrackingUseCase {
  final TrackingRepository repository;

  StartTrackingUseCase(this.repository);

  Stream<DriverLocation> call() {
    return repository.startTracking();
  }
}

