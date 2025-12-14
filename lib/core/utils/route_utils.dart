import 'package:latlong2/latlong.dart';

class RouteUtils {
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const distance = Distance();
    return distance.as(
      LengthUnit.Meter,
      LatLng(lat1, lon1),
      LatLng(lat2, lon2),
    );
  }
  
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(2)} km';
    }
  }
  
  static String calculateETA(double distanceInMeters, double speedKmh) {
    if (speedKmh <= 0) return 'Calculating...';
    
    final hours = distanceInMeters / (speedKmh * 1000);
    final minutes = (hours * 60).round();
    
    if (minutes < 1) return 'Less than 1 min';
    if (minutes < 60) return '$minutes min';
    
    final hrs = minutes ~/ 60;
    final mins = minutes % 60;
    return mins > 0 ? '$hrs h $mins min' : '$hrs h';
  }
  
  static List<LatLng> generatePolylinePoints(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    int segments,
  ) {
    final points = <LatLng>[];
    for (int i = 0; i <= segments; i++) {
      final ratio = i / segments;
      final lat = startLat + (endLat - startLat) * ratio;
      final lng = startLng + (endLng - startLng) * ratio;
      points.add(LatLng(lat, lng));
    }
    return points;
  }
}

