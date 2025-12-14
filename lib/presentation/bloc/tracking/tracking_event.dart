import 'package:equatable/equatable.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object> get props => [];
}

class StartTrackingEvent extends TrackingEvent {
  const StartTrackingEvent();
}

class StopTrackingEvent extends TrackingEvent {
  const StopTrackingEvent();
}

class LocationUpdatedEvent extends TrackingEvent {
  final dynamic location;

  const LocationUpdatedEvent(this.location);

  @override
  List<Object> get props => [location];
}

