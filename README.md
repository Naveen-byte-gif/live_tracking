# RouteSense - Live Delivery Tracking Module

A Flutter application demonstrating real-time delivery tracking with simulated driver movement, built using Clean Architecture (MVVM) and BLoC state management.

## 📱 Features

- **Live Map Tracking**: Real-time driver movement visualization on OpenStreetMap
- **Smooth Marker Animation**: Driver marker moves smoothly across the map with heading direction
- **Route Polyline**: Visual route line connecting driver and destination
- **Dynamic ETA & Distance**: Auto-updating estimated time of arrival and distance calculations
- **Delivery Status Tracking**: Four status stages (Picked, En Route, Arriving, Delivered)
- **Interactive Bottom Sheet**: Draggable bottom sheet with driver details and delivery information
- **Mock Location Service**: Simulated WebSocket-like stream emitting location updates every 2-3 seconds

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **MVVM** pattern and **BLoC** state management:

```
lib/
├── core/                    # Core utilities and constants
│   ├── constants/          # App-wide constants
│   └── utils/              # Utility functions
├── domain/                  # Business Logic Layer
│   ├── entities/           # Domain models
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business use cases
├── data/                    # Data Layer
│   ├── datasources/        # Data sources (Mock services)
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
└── presentation/            # Presentation Layer
    ├── bloc/               # BLoC state management
    │   ├── map/           # Map-related BLoC
    │   └── tracking/      # Tracking BLoC
    ├── screens/            # UI screens
    ├── viewmodels/         # ViewModels
    └── widgets/            # Reusable widgets
```

### Architecture Layers

1. **Domain Layer** (Business Logic)
   - Pure Dart classes with no dependencies
   - Entities: `DriverLocation`, `DeliveryInfo`
   - Repository interfaces
   - Use cases: `StartTrackingUseCase`, `StopTrackingUseCase`

2. **Data Layer** (Data Sources)
   - Implements domain repository interfaces
   - `MockLocationService`: Simulates real-time location updates
   - Models: Data transfer objects extending entities

3. **Presentation Layer** (UI & State)
   - BLoC pattern for state management
   - `TrackingBloc`: Manages tracking state and location updates
   - `MapBloc`: Handles map camera and marker updates
   - ViewModels: Business logic for UI
   - Screens and Widgets: UI components

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (3.10.1 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android builds)
- Xcode (for iOS builds, macOS only)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd route_sense
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For Android
   flutter run

   # For iOS (macOS only)
   flutter run -d ios

   # For specific device
   flutter devices
   flutter run -d <device-id>
   ```

4. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```
   The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

5. **Build IPA (iOS)**
   ```bash
   flutter build ios --release
   ```

## 📦 Dependencies

- **flutter_bloc**: ^8.1.6 - State management
- **equatable**: ^2.0.5 - Value equality
- **flutter_map**: ^7.0.2 - Map widget
- **latlong2**: ^0.9.1 - Geographic coordinates
- **intl**: ^0.19.0 - Internationalization and date formatting
- **path_provider**: ^2.1.2 - File system paths

## 🎯 How It Works

### Mock Location Service

The `MockLocationService` simulates real-time driver movement:

- Emits location updates every 2-3 seconds
- Uses predefined route coordinates from `AppConstants`
- Calculates realistic speed and heading based on delivery status
- Automatically transitions through delivery statuses:
  - **Picked** (0-10% progress): Low speed (5-10 km/h)
  - **En Route** (10-90% progress): Normal speed (30-50 km/h)
  - **Arriving** (90-95% progress): Reduced speed (10-20 km/h)
  - **Delivered** (95-100% progress): Stopped (0 km/h)

### BLoC State Management

#### TrackingBloc
- **Events**: `StartTrackingEvent`, `StopTrackingEvent`, `LocationUpdatedEvent`
- **States**: `TrackingInitial`, `TrackingLoading`, `TrackingActive`, `TrackingStopped`, `TrackingError`
- Handles location stream subscription and delivery info calculation

#### MapBloc
- **Events**: `UpdateDriverPositionEvent`, `UpdateCameraEvent`, `ResetMapEvent`
- **State**: `MapState` with driver position, heading, and camera settings
- Manages map marker positions and camera movements

### UI Components

- **TrackingScreen**: Main screen with map and bottom sheet
- **DriverMarker**: Animated marker showing driver position and heading
- **DestinationMarker**: Static marker for delivery destination
- **DeliveryBottomSheet**: Draggable sheet with delivery information

## 📱 Usage

1. **Start Tracking**: Tap the play button (▶️) in the app bar
2. **View Live Updates**: Watch the driver marker move across the map
3. **Check Details**: Swipe up the bottom sheet to see delivery information
4. **Stop Tracking**: Tap the stop button (⏹️) to end tracking

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Code Structure

- **Clean Code**: Each file is under 400 lines
- **Separation of Concerns**: Clear separation between layers
- **Single Responsibility**: Each class has one clear purpose
- **Dependency Injection**: Use cases and repositories are injected
- **Immutability**: Entities use Equatable for value equality

## 🎨 UI/UX Features

- Modern Material Design 3
- Smooth animations and transitions
- Responsive bottom sheet
- Color-coded delivery status
- Real-time ETA and distance updates
- Last updated timestamp

## 🔧 Configuration

### Customize Route

Edit `lib/core/constants/app_constants.dart` to change:
- Route coordinates
- Driver information
- Destination location
- Update interval

### Customize Map

Modify map settings in:
- `AppConstants`: Zoom levels and initial position
- `MapBloc`: Camera behavior
- `TrackingScreen`: Map styling

## 📄 License

This project is created for interview/assignment purposes.

## 👨‍💻 Developer Notes

- All code follows Flutter best practices
- Clean Architecture ensures testability and maintainability
- BLoC pattern provides predictable state management
- Mock service can be easily replaced with real WebSocket implementation
- Code is well-documented and self-explanatory

## 🐛 Known Issues

None at the moment. The app is fully functional with simulated data.

## 📞 Support

For questions or issues, please refer to the code comments or create an issue in the repository.

---

**Built with ❤️ using Flutter**
