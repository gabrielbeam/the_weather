import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_weather/api/meteomatics.dart';
import 'package:the_weather/common/custom_app_bar.dart';
import 'package:the_weather/common/geolocator.dart';
import 'package:the_weather/models/precipitation_response.dart';
import 'package:the_weather/packages/bottom_navigator.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng? _currentP = null;
  double _precipitation = 0.0;

  @override
  void initState() {
    super.initState();
    determinePosition().then((value) {
      _updateMarkerPosition(LatLng(value.latitude, value.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Google Map"),
      body: _currentP == null
          ? Center(child: Text("Loading...", style: TextStyle(fontSize: 20)))
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: _currentP!, zoom: 13),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _updateMarkerPosition,
              markers: {
                Marker(
                  markerId: MarkerId('my-location'),
                  position: _currentP!,
                  infoWindow: InfoWindow(
                    title: 'My Location',
                    snippet:
                        'Last hour precipitation (mm): ${_precipitation.toString()}',
                  ),
                ),
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getMyLocation,
        label: const Text('Bring me to my location'),
        icon: const Icon(Icons.add_location_outlined),
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Future<void> _getMyLocation() async {
    final GoogleMapController controller = await _controller.future;
    await determinePosition().then((value) async => {
          await controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 13,
              ),
            ),
          )
        });
  }

  void _updateMarkerPosition(LatLng newPosition) {
    _updatePrecipitation(newPosition);
    setState(() {
      _currentP = newPosition; // Update the current position
    });
  }

  void _updatePrecipitation(LatLng newPosition) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now().toUtc();
    String timestamp = now.toIso8601String();
    await getPrecipitationData(
            timestamp: timestamp,
            lat: newPosition.latitude,
            lon: newPosition.longitude)
        .then((value) {
      if (value.data.isNotEmpty) {
        double lastHourPrecipitation =
            value.data[0].coordinates[0].dates.last.value;
        setState(() {
          _precipitation = lastHourPrecipitation;
        });
        double lastDayPrecipitation = 0.0;
        for (var e in value.data[0].coordinates[0].dates) {
          lastDayPrecipitation += e.value;
        }
        prefs.setDouble("lastDayPrecipitation", lastDayPrecipitation);
      }
    });
  }
}
