import 'package:equatable/equatable.dart';
import '../../../domain/entities/delivery_info.dart';

abstract class TrackingState extends Equatable {
  const TrackingState();

  @override
  List<Object> get props => [];
}

class TrackingInitial extends TrackingState {
  const TrackingInitial();
}

class TrackingLoading extends TrackingState {
  const TrackingLoading();
}

class TrackingActive extends TrackingState {
  final DeliveryInfo deliveryInfo;

  const TrackingActive(this.deliveryInfo);

  @override
  List<Object> get props => [deliveryInfo];
}

class TrackingStopped extends TrackingState {
  const TrackingStopped();
}

class TrackingError extends TrackingState {
  final String message;

  const TrackingError(this.message);

  @override
  List<Object> get props => [message];
}

