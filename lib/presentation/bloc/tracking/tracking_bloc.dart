import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/route_utils.dart';
import '../../../domain/entities/delivery_info.dart';
import '../../../domain/entities/driver_location.dart';
import '../../../domain/usecases/start_tracking_usecase.dart';
import '../../../domain/usecases/stop_tracking_usecase.dart';
import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final StartTrackingUseCase startTrackingUseCase;
  final StopTrackingUseCase stopTrackingUseCase;
  StreamSubscription<DriverLocation>? _locationSubscription;

  TrackingBloc({
    required this.startTrackingUseCase,
    required this.stopTrackingUseCase,
  }) : super(const TrackingInitial()) {
    on<StartTrackingEvent>(_onStartTracking);
    on<StopTrackingEvent>(_onStopTracking);
    on<LocationUpdatedEvent>(_onLocationUpdated);
  }

  Future<void> _onStartTracking(
    StartTrackingEvent event,
    Emitter<TrackingState> emit,
  ) async {
    emit(const TrackingLoading());
    
    try {
      _locationSubscription?.cancel();
      _locationSubscription = startTrackingUseCase().listen(
        (location) => add(LocationUpdatedEvent(location)),
        onError: (error) => emit(TrackingError(error.toString())),
      );
    } catch (e) {
      emit(TrackingError(e.toString()));
    }
  }

  void _onStopTracking(
    StopTrackingEvent event,
    Emitter<TrackingState> emit,
  ) {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    stopTrackingUseCase();
    emit(const TrackingStopped());
  }

  void _onLocationUpdated(
    LocationUpdatedEvent event,
    Emitter<TrackingState> emit,
  ) {
    if (event.location is! DriverLocation) return;

    final location = event.location as DriverLocation;
    
    final distance = RouteUtils.calculateDistance(
      location.lat,
      location.lng,
      AppConstants.destinationLat,
      AppConstants.destinationLng,
    );

    final eta = RouteUtils.calculateETA(
      distance,
      location.speed,
    );

    final deliveryInfo = DeliveryInfo(
      driverLocation: location,
      destinationLat: AppConstants.destinationLat,
      destinationLng: AppConstants.destinationLng,
      driverName: AppConstants.driverName,
      driverPhone: AppConstants.driverPhone,
      vehicleNumber: AppConstants.vehicleNumber,
      distance: distance,
      eta: eta,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
        location.timestamp * 1000,
      ),
    );

    emit(TrackingActive(deliveryInfo));
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}

