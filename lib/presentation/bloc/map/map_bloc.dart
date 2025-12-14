import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/constants/app_constants.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(
          MapState(
            driverPosition: LatLng(
              AppConstants.sampleRoute[0]['lat']!,
              AppConstants.sampleRoute[0]['lng']!,
            ),
            driverHeading: 0.0,
            cameraCenter: LatLng(
              AppConstants.sampleRoute[0]['lat']!,
              AppConstants.sampleRoute[0]['lng']!,
            ),
            cameraZoom: AppConstants.defaultZoom,
            isInitialized: false,
          ),
        ) {
    on<UpdateDriverPositionEvent>(_onUpdateDriverPosition);
    on<UpdateCameraEvent>(_onUpdateCamera);
    on<ResetMapEvent>(_onResetMap);
  }

  void _onUpdateDriverPosition(
    UpdateDriverPositionEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        driverPosition: event.position,
        driverHeading: event.heading,
        cameraCenter: event.position,
        isInitialized: true,
      ),
    );
  }

  void _onUpdateCamera(
    UpdateCameraEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        cameraCenter: event.center,
        cameraZoom: event.zoom,
      ),
    );
  }

  void _onResetMap(
    ResetMapEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      MapState(
        driverPosition: LatLng(
          AppConstants.sampleRoute[0]['lat']!,
          AppConstants.sampleRoute[0]['lng']!,
        ),
        driverHeading: 0.0,
        cameraCenter: LatLng(
          AppConstants.sampleRoute[0]['lat']!,
          AppConstants.sampleRoute[0]['lng']!,
        ),
        cameraZoom: AppConstants.defaultZoom,
        isInitialized: false,
      ),
    );
  }
}

