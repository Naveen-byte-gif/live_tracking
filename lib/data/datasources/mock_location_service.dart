import 'dart:async';
import 'dart:math';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/driver_location.dart';
import '../models/driver_location_model.dart';

class MockLocationService {
  Timer? _timer;
  StreamController<DriverLocation>? _controller;
  int _currentIndex = 0;
  bool _isRunning = false;

  Stream<DriverLocation> startTracking() {
    if (_isRunning) {
      return _controller!.stream;
    }

    _controller = StreamController<DriverLocation>.broadcast();
    _isRunning = true;
    _currentIndex = 0;

    _emitLocation();
    _timer = Timer.periodic(
      const Duration(seconds: AppConstants.locationUpdateInterval),
      (_) => _emitLocation(),
    );

    return _controller!.stream;
  }

  void stopTracking() {
    _timer?.cancel();
    _timer = null;
    _controller?.close();
    _controller = null;
    _isRunning = false;
    _currentIndex = 0;
  }

  bool get isTracking => _isRunning;

  void _emitLocation() {
    if (_currentIndex >= AppConstants.sampleRoute.length) {
      stopTracking();
      return;
    }

    final routePoint = AppConstants.sampleRoute[_currentIndex];
    final progress = _currentIndex / AppConstants.sampleRoute.length;

    final status = _getStatusForProgress(progress);
    final speed = _getSpeedForStatus(status);
    final heading = _calculateHeading();

    final location = DriverLocationModel(
      lat: routePoint['lat']!,
      lng: routePoint['lng']!,
      speed: speed,
      heading: heading,
      status: status,
      timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    _controller?.add(location);
    _currentIndex++;
  }

  DeliveryStatus _getStatusForProgress(double progress) {
    // Updated flow: Picked -> Arriving -> Delivered
    if (progress < 0.3) return DeliveryStatus.picked;
    if (progress < 0.95) return DeliveryStatus.arriving;
    return DeliveryStatus.delivered;
  }

  double _getSpeedForStatus(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.picked:
        return 5.0 + Random().nextDouble() * 5.0;
      case DeliveryStatus.enRoute:
        // Keep for backward compatibility, but treat as arriving
        return 20.0 + Random().nextDouble() * 15.0;
      case DeliveryStatus.arriving:
        return 10.0 + Random().nextDouble() * 10.0;
      case DeliveryStatus.delivered:
        return 0.0;
    }
  }

  double _calculateHeading() {
    if (_currentIndex == 0) return 0.0;
    
    final current = AppConstants.sampleRoute[_currentIndex];
    final previous = AppConstants.sampleRoute[_currentIndex - 1];
    
    final lat1 = previous['lat']! * pi / 180;
    final lat2 = current['lat']! * pi / 180;
    final dLon = (current['lng']! - previous['lng']!) * pi / 180;
    
    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    
    final bearing = atan2(y, x) * 180 / pi;
    return (bearing + 360) % 360;
  }
}

