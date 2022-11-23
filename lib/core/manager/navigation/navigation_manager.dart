import 'package:flutter/material.dart';
import 'package:leaflet_task/core/constants/navigation_constant.dart';
import 'package:leaflet_task/features/bluetooth/bluetooth_view.dart';
import 'package:leaflet_task/features/map/map_view.dart';

class NavigationManager {
  NavigationManager._init();
  static final NavigationManager _instance = NavigationManager._init();
  static NavigationManager get instance => _instance;

  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstant.map:
        return pageRoute(NavigationConstant.map, const MapView());
      case NavigationConstant.blue:
        return pageRoute(NavigationConstant.blue, BluetoothView());
    }
    return null;
  }

  MaterialPageRoute pageRoute(String routeName, Widget view, {Object? data}) {
    return MaterialPageRoute(
      builder: (context) => view,
      settings: RouteSettings(
        name: routeName,
        arguments: data,
      ),
    );
  }
}
