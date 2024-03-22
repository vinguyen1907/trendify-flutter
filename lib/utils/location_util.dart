import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationUtil {
  Future<bool> _handleLocationPermission(
      {required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showSnackBar(
          context: context,
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showSnackBar(
            context: context, message: 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.showSnackBar(
          context: context,
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<LatLng?> getCurrentPosition({required BuildContext context}) async {
    final hasPermission = await _handleLocationPermission(context: context);
    if (!hasPermission) return null;

    try {
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(location.latitude, location.longitude);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Placemark> getLocationFromLatLng({required LatLng latLng}) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = placemarks[0];
      return place;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isEmpty) {
        return null;
      }
      return LatLng(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      throw Exception(e);
    }
  }
}
