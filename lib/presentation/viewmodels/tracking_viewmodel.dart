import '../../../domain/entities/delivery_info.dart';
import '../bloc/tracking/tracking_state.dart';

class TrackingViewModel {
  DeliveryInfo? getDeliveryInfo(TrackingState state) {
    if (state is TrackingActive) {
      return state.deliveryInfo;
    }
    return null;
  }

  bool isLoading(TrackingState state) {
    return state is TrackingLoading;
  }

  bool isTracking(TrackingState state) {
    return state is TrackingActive;
  }

  bool isStopped(TrackingState state) {
    return state is TrackingStopped;
  }

  String? getErrorMessage(TrackingState state) {
    if (state is TrackingError) {
      return state.message;
    }
    return null;
  }
}
