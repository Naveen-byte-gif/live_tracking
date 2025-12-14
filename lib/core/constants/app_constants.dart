class AppConstants {
  // Map Configuration
  static const double defaultZoom = 15.0; // Closer zoom for detailed tracking
  static const double minZoom = 12.0;
  static const double maxZoom = 18.0;
  
  // Location Update Interval (seconds)
  static const int locationUpdateInterval = 2;
  
  // Route Coordinates (Sample route in a city)
  static const List<Map<String, double>> sampleRoute = [
    {'lat': 28.6139, 'lng': 77.2090}, // Start: Delhi
    {'lat': 28.6140, 'lng': 77.2095},
    {'lat': 28.6145, 'lng': 77.2100},
    {'lat': 28.6150, 'lng': 77.2105},
    {'lat': 28.6155, 'lng': 77.2110},
    {'lat': 28.6160, 'lng': 77.2115},
    {'lat': 28.6165, 'lng': 77.2120},
    {'lat': 28.6170, 'lng': 77.2125},
    {'lat': 28.6175, 'lng': 77.2130},
    {'lat': 28.6180, 'lng': 77.2135},
    {'lat': 28.6185, 'lng': 77.2140},
    {'lat': 28.6190, 'lng': 77.2145},
    {'lat': 28.6195, 'lng': 77.2150},
    {'lat': 28.6200, 'lng': 77.2155},
    {'lat': 28.6205, 'lng': 77.2160},
    {'lat': 28.6210, 'lng': 77.2165},
    {'lat': 28.6215, 'lng': 77.2170},
    {'lat': 28.6220, 'lng': 77.2175},
    {'lat': 28.6225, 'lng': 77.2180},
    {'lat': 28.6230, 'lng': 77.2185}, // Destination
  ];
  
  // Driver Details
  static const String driverName = 'Naveen T';
  static const String driverPhone = '8106651649';
  static const String driverEmail = 'tungananaveenjob18@gmail.com';
  static const String vehicleNumber = 'KA 01 AB 1234';
  static const double driverRating = 4.8;
  
  // App Details
  static const String appName = 'Delivery Tracker Pro';
  static const String appDescription = 'Real-time delivery tracking with live updates';
  
  // Color Scheme
  static const int primaryColorValue = 0xFF184f68; // Dark Teal
  static const int secondaryColorValue = 0xFFbcb59a; // Beige
  
  // Destination
  static const double destinationLat = 28.6230;
  static const double destinationLng = 77.2185;
}

