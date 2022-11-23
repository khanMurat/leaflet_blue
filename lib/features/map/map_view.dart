import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:leaflet_task/components/custom_button.dart';
import 'package:leaflet_task/components/custom_drawer.dart';
import 'package:leaflet_task/core/constants/map_key_constant.dart';
import 'package:leaflet_task/core/constants/size_constant.dart';
import 'package:leaflet_task/core/extension/context_extension.dart';

enum LocationIcon { city, add }

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<Marker> markersList = [];
  List<LatLng> pointsList = [];

  bool isVisible = false;

  final double _centerLatitude = 39.9300;
  final double _centerLongitude = 32.8597;
  final double _zoomValue = 11.7;
  final String _title = "Leaflet Map";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(_title),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.show_chart),
        onPressed: () {
          _bottomSheet(context);
        },
      ),
      body: SafeArea(
        child: FlutterMap(
          options: MapOptions(
            onLongPress: (tapPosition, point) {
              final marker = Marker(
                  width: Sizes.p80,
                  height: Sizes.p80,
                  point: point,
                  builder: (context) {
                    return GestureDetector(
                      child: const Icon(
                        Icons.location_city,
                        size: Sizes.p30,
                      ),
                    );
                  });
              markersList.add(marker);
              pointsList.add(point);
            },
            center: LatLng(_centerLatitude, _centerLongitude),
            zoom: _zoomValue,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: MapKeyConstant.attributeSource,
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
                urlTemplate: MapKeyConstant.mapURL,
                subdomains: MapKeyConstant.subDomain,
                userAgentPackageName: MapKeyConstant.packageName),
            MarkerLayer(markers: markersList),
            PolylineLayer(
              polylineCulling: false,
              polylines: [
                Polyline(
                    points: pointsList,
                    strokeWidth: 5.5,
                    color:
                        isVisible == true ? Colors.transparent : Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return SizedBox(
          height: context.heightRate(Sizes.p40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                text: "Delete markers but last",
                onPressed: () {
                  setState(() {
                    if (markersList.isNotEmpty) {
                      markersList.removeRange(0, markersList.length - 1);
                      pointsList.clear();
                    }
                  });
                  Navigator.pop(context);
                },
              ),
              gapH20,
              CustomButton(
                text: "Show/Hide Lines",
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                  Navigator.pop(context);
                },
              ),
              gapH20,
              CustomButton(
                text: "Delete All Markers",
                onPressed: () {
                  setState(() {
                    if (markersList.isNotEmpty) {
                      markersList.clear();
                      pointsList.clear();
                    }
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
