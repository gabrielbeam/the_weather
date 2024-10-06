import 'package:geolocator/geolocator.dart';


Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  int tryRequestPermissionCount = 0;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  while (tryRequestPermissionCount < 3 && permission == LocationPermission.denied) {
    tryRequestPermissionCount++;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (tryRequestPermissionCount >= 3) {
      return Future.error('Location permissions are denied');
    }
  
  if (permission == LocationPermission.deniedForever) { 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  return await Geolocator.getCurrentPosition();
}