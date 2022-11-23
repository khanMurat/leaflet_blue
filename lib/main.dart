import 'package:flutter/material.dart';
import 'package:leaflet_task/features/map/map_view.dart';
import 'core/manager/navigation/navigation_manager.dart';
import 'core/manager/navigation/navigation_service.dart';

void main() {
  runApp(const FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: NavigationManager.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigationKey,
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      home: const MapView(),
    );
  }
}
