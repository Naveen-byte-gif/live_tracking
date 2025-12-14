import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/route_utils.dart';
import '../bloc/map/map_bloc.dart';
import '../bloc/map/map_event.dart';
import '../bloc/map/map_state.dart';
import '../bloc/tracking/tracking_bloc.dart';
import '../bloc/tracking/tracking_event.dart';
import '../bloc/tracking/tracking_state.dart';
import '../viewmodels/tracking_viewmodel.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/delivery_bottom_sheet.dart';
import '../widgets/destination_marker.dart';
import '../widgets/driver_marker.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final MapController _mapController = MapController();
  final TrackingViewModel _viewModel = TrackingViewModel();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            return CustomAppBar(
              isTracking: _viewModel.isTracking(state),
              onPlayPressed: () {
                context.read<TrackingBloc>().add(const StartTrackingEvent());
              },
              onStopPressed: () {
                context.read<TrackingBloc>().add(const StopTrackingEvent());
                context.read<MapBloc>().add(const ResetMapEvent());
              },
            );
          },
        ),
      ),
      body: BlocListener<TrackingBloc, TrackingState>(
        listener: (context, state) {
          final deliveryInfo = _viewModel.getDeliveryInfo(state);
          if (deliveryInfo != null) {
            context.read<MapBloc>().add(
                  UpdateDriverPositionEvent(
                    position: LatLng(
                      deliveryInfo.driverLocation.lat,
                      deliveryInfo.driverLocation.lng,
                    ),
                    heading: deliveryInfo.driverLocation.heading,
                  ),
                );
          }
        },
        child: BlocListener<MapBloc, MapState>(
          listener: (context, mapState) {
            if (mapState.isInitialized) {
              _mapController.move(
                mapState.cameraCenter,
                mapState.cameraZoom,
              );
            }
          },
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              return Stack(
                children: [
                  _buildMap(mapState),
                  _buildBottomSheet(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMap(MapState mapState) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: mapState.cameraCenter,
        initialZoom: mapState.cameraZoom,
        minZoom: AppConstants.minZoom,
        maxZoom: AppConstants.maxZoom,
        keepAlive: true,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.routesense.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: mapState.driverPosition,
              width: 40,
              height: 40,
              child: DriverMarker(
                heading: mapState.driverHeading,
              ),
            ),
            Marker(
              point: LatLng(
                AppConstants.destinationLat,
                AppConstants.destinationLng,
              ),
              width: 30,
              height: 30,
              child: const DestinationMarker(),
            ),
          ],
        ),
        BlocBuilder<TrackingBloc, TrackingState>(
          builder: (context, state) {
            final deliveryInfo = _viewModel.getDeliveryInfo(state);
            if (deliveryInfo == null) return const SizedBox.shrink();

            final polylinePoints = RouteUtils.generatePolylinePoints(
              deliveryInfo.driverLocation.lat,
              deliveryInfo.driverLocation.lng,
              deliveryInfo.destinationLat,
              deliveryInfo.destinationLng,
              20,
            );

            return PolylineLayer(
              polylines: [
                Polyline(
                  points: polylinePoints,
                  strokeWidth: 6.0,
                  color: const Color(0xFF184f68), // Dark Teal
                  borderStrokeWidth: 3.0,
                  borderColor: const Color(0xFFbcb59a), // Beige
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomSheet() {
    return BlocBuilder<TrackingBloc, TrackingState>(
      builder: (context, state) {
        if (_viewModel.isLoading(state)) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final deliveryInfo = _viewModel.getDeliveryInfo(state);
        if (deliveryInfo == null) {
          return const SizedBox.shrink();
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.4,
          maxChildSize: 0.75,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: DeliveryBottomSheet(
                deliveryInfo: deliveryInfo,
              ),
            );
          },
        );
      },
    );
  }
}

