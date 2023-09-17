import 'dart:async';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:refilin_mobile/app/providers/google_maps_provider.dart';

class LocationService extends GetxService {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';
  final googleMapsProvider = Get.find<GoogleMapsProvider>();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    _updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    final positionItem = _PositionItem(type, displayValue);
    // Handle the positionItem as needed (e.g., store in a list, update UI, etc.)
  }

  Future<String?> getAddressFromCoordinates(
      {required double latitude, required double longitude}) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude,
          localeIdentifier: 'id_ID');
      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        print(placemark.toJson());
        final String address =
            "${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}";
        return address;
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return null;
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const int earthRadius = 6371000; // Earth's radius in meters

    // Convert degrees to radians
    double startLatRad = startLatitude * (pi / 180.0);
    double startLonRad = startLongitude * (pi / 180.0);
    double endLatRad = endLatitude * (pi / 180.0);
    double endLonRad = endLongitude * (pi / 180.0);

    // Calculate differences between the two points
    double latDiff = endLatRad - startLatRad;
    double lonDiff = endLonRad - startLonRad;

    // Calculate the distance using the Haversine formula
    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(startLatRad) * cos(endLatRad) * sin(lonDiff / 2) * sin(lonDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

//distanceFormatted "km or m;"
  String formatDistance(double distance) {
    String distanceFormatted = '';
    if (distance < 1000) {
      distanceFormatted = '${distance.toStringAsFixed(0)} m';
    } else {
      final double distanceInKm = distance / 1000;
      distanceFormatted = '${distanceInKm.toStringAsFixed(1)} km';
    }
    return distanceFormatted;
  }

  Future<double> calculateDistanceWithGoogleMapsAPI(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) async {
    final String origin = '$startLatitude,$startLongitude';
    final String destination = '$endLatitude,$endLongitude';

    // final String url =
    //     '$_baseUrl?origin=$origin&destination=$destination&key=$_apiKey';
    print("origin: $origin, destination: $destination");
    final response = await googleMapsProvider.getDistance(
        origin: origin, destination: destination);
    print("response google maps: ${response.body}");
    if (response.statusCode == 200) {
      // final data = response.body['data'];
      // print("data google maps: $data");
      // final distance = data['rows'][0]['elements'][0]['distance']['value'];
      // print("distance google maps: $distance");
      // return distance.toDouble();
    }

    throw Exception('Error calculating distance using Google Maps API.');
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
