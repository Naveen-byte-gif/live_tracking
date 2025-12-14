import '../repositories/tracking_repository.dart';

class StopTrackingUseCase {
  final TrackingRepository repository;

  StopTrackingUseCase(this.repository);

  void call() {
    repository.stopTracking();
  }
}

