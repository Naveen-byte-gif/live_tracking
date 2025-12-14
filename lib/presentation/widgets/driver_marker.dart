import 'package:flutter/material.dart';

class DriverMarker extends StatelessWidget {
  final double heading;

  const DriverMarker({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (heading * 3.14159265359) / 180,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF184f68), // Dark Teal
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFbcb59a), // Beige border
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(Icons.directions_bike, color: Colors.white, size: 20),
      ),
    );
  }
}
