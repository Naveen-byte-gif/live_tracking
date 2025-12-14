# Architecture Documentation

## Clean Architecture Overview

This project follows Clean Architecture principles with three main layers:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (BLoC, ViewModels, Screens, Widgets)  │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│          Domain Layer                   │
│  (Entities, Use Cases, Repositories)    │
└─────────────────┬───────────────────────┘
                  │
┌─────────────────▼───────────────────────┐
│           Data Layer                    │
│  (Models, Data Sources, Repositories)   │
└─────────────────────────────────────────┘
```

## Layer Responsibilities

### 1. Domain Layer (Business Logic)
**Location**: `lib/domain/`

- **Entities**: Pure Dart classes representing business objects
  - `DriverLocation`: Driver's current location and status
  - `DeliveryInfo`: Complete delivery information
  
- **Repositories**: Abstract interfaces defining data contracts
  - `TrackingRepository`: Interface for location tracking operations
  
- **Use Cases**: Business logic operations
  - `StartTrackingUseCase`: Initiates location tracking
  - `StopTrackingUseCase`: Stops location tracking

**Key Principle**: No dependencies on other layers. Pure business logic.

### 2. Data Layer (Data Sources)
**Location**: `lib/data/`

- **Data Sources**: Implementation of data fetching
  - `MockLocationService`: Simulates WebSocket-like location stream
  
- **Models**: Data transfer objects extending entities
  - `DriverLocationModel`: Extends `DriverLocation` with JSON serialization
  
- **Repository Implementations**: Concrete implementations of domain repositories
  - `TrackingRepositoryImpl`: Implements `TrackingRepository`

**Key Principle**: Implements domain interfaces, handles data transformation.

### 3. Presentation Layer (UI & State)
**Location**: `lib/presentation/`

- **BLoC**: State management
  - `TrackingBloc`: Manages tracking state and location updates
  - `MapBloc`: Handles map camera and marker state
  
- **ViewModels**: Business logic for UI
  - `TrackingViewModel`: Provides helper methods for UI state
  
- **Screens**: UI pages
  - `TrackingScreen`: Main tracking interface
  
- **Widgets**: Reusable UI components
  - `DriverMarker`: Animated driver marker
  - `DestinationMarker`: Destination marker
  - `DeliveryBottomSheet`: Delivery information sheet

**Key Principle**: Depends on domain layer, uses BLoC for state management.

## Data Flow

### Starting Tracking
```
User Action (Play Button)
    ↓
TrackingScreen → StartTrackingEvent
    ↓
TrackingBloc → StartTrackingUseCase
    ↓
TrackingRepository → MockLocationService.startTracking()
    ↓
Stream<DriverLocation> emitted every 2-3 seconds
    ↓
LocationUpdatedEvent → TrackingBloc
    ↓
TrackingActive State → UI Update
```

### Location Update Flow
```
MockLocationService emits DriverLocation
    ↓
TrackingBloc receives LocationUpdatedEvent
    ↓
Calculate distance, ETA, create DeliveryInfo
    ↓
Emit TrackingActive state
    ↓
MapBloc receives UpdateDriverPositionEvent
    ↓
Update map markers and camera
    ↓
UI rebuilds with new data
```

## BLoC Pattern

### TrackingBloc
**Events**:
- `StartTrackingEvent`: Begin location tracking
- `StopTrackingEvent`: Stop tracking
- `LocationUpdatedEvent`: New location received

**States**:
- `TrackingInitial`: Initial state
- `TrackingLoading`: Starting tracking
- `TrackingActive`: Active tracking with delivery info
- `TrackingStopped`: Tracking stopped
- `TrackingError`: Error occurred

### MapBloc
**Events**:
- `UpdateDriverPositionEvent`: Update driver marker position
- `UpdateCameraEvent`: Update map camera
- `ResetMapEvent`: Reset map to initial state

**State**:
- `MapState`: Contains driver position, heading, camera settings

## Dependency Injection

Dependencies are injected in `main.dart`:

```dart
MockLocationService → TrackingRepositoryImpl → Use Cases → BLoC
```

This allows easy testing and swapping implementations (e.g., real WebSocket instead of mock).

## File Organization

```
lib/
├── core/                    # Shared utilities
│   ├── constants/          # App constants
│   └── utils/              # Helper functions
├── domain/                  # Business logic
│   ├── entities/           # Domain models
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business use cases
├── data/                    # Data layer
│   ├── datasources/        # Data sources
│   ├── models/             # Data models
│   └── repositories/       # Repository implementations
└── presentation/            # UI layer
    ├── bloc/               # State management
    ├── screens/            # UI screens
    ├── viewmodels/         # ViewModels
    └── widgets/            # Reusable widgets
```

## Code Quality

- ✅ Each file under 400 lines
- ✅ Single Responsibility Principle
- ✅ Dependency Inversion (domain doesn't depend on data)
- ✅ Separation of Concerns
- ✅ Clean imports (only what's needed)
- ✅ Immutable entities (Equatable)
- ✅ Proper error handling

## Testing Strategy

The architecture supports easy testing:

1. **Domain Layer**: Test use cases with mock repositories
2. **Data Layer**: Test repository implementations with mock data sources
3. **Presentation Layer**: Test BLoCs with mock use cases

## Future Enhancements

- Replace `MockLocationService` with real WebSocket
- Add unit tests for each layer
- Add integration tests
- Implement offline caching
- Add route optimization

