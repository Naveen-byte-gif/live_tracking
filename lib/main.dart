import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasources/mock_location_service.dart';
import 'data/repositories/tracking_repository_impl.dart';
import 'domain/usecases/start_tracking_usecase.dart';
import 'domain/usecases/stop_tracking_usecase.dart';
import 'presentation/bloc/map/map_bloc.dart';
import 'presentation/bloc/tracking/tracking_bloc.dart';
import 'presentation/screens/tracking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Tracker Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapBloc(),
          ),
          BlocProvider(
            create: (context) {
              final locationService = MockLocationService();
              final repository = TrackingRepositoryImpl(locationService);
              return TrackingBloc(
                startTrackingUseCase: StartTrackingUseCase(repository),
                stopTrackingUseCase: StopTrackingUseCase(repository),
              );
            },
          ),
        ],
        child: const TrackingScreen(),
      ),
    );
  }
}
