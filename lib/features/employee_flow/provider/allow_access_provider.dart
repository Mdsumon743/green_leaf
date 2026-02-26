

import 'dart:developer';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/service/app_url.dart';
import '../../../core/service/network_caller.dart';

class AllowAccessState {
  final LatLng selectedLocation;
  final String? accessToken;
  final bool isLoading;
  final bool isUpdatingLocation;
  final Set<Marker> markers;
  final bool locationUpdateSuccess;
  final String? errorMessage;

  AllowAccessState({
    required this.selectedLocation,
    this.accessToken,
    this.isLoading = false,
    this.isUpdatingLocation = false,
    this.locationUpdateSuccess = false,
    this.errorMessage,
    Set<Marker>? markers,
  }) : markers = markers ?? {};

  AllowAccessState copyWith({
    LatLng? selectedLocation,
    String? accessToken,
    bool? isLoading,
    bool? isUpdatingLocation,
    bool? locationUpdateSuccess,
    String? errorMessage,
    Set<Marker>? markers,
  }) {
    return AllowAccessState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      accessToken: accessToken ?? this.accessToken,
      isLoading: isLoading ?? this.isLoading,
      isUpdatingLocation: isUpdatingLocation ?? this.isUpdatingLocation,
      locationUpdateSuccess: locationUpdateSuccess ?? this.locationUpdateSuccess,
      errorMessage: errorMessage,
      markers: markers ?? this.markers,
    );
  }
}

class AllowAccessNotifier extends StateNotifier<AllowAccessState> {
  AllowAccessNotifier()
      : super(
    AllowAccessState(selectedLocation: const LatLng(12.9629, 77.5775)),
  ) {
    _addMarker(state.selectedLocation);
  }

  final NetworkCaller networkCaller = NetworkCaller();

  GoogleMapController? mapController;

  // Set access token
  void setAccessToken(String token) {
    log("🔑 Setting access token: $token");
    state = state.copyWith(accessToken: token);
  }

  // Set map controller
  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  // Map tapped
  void onMapTapped(LatLng position) {
    state = state.copyWith(selectedLocation: position);
    _addMarker(position);
    _animateToPosition(position);
  }

  // Add marker
  void _addMarker(LatLng position) {
    state = state.copyWith(
      markers: {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      },
    );
  }

  // Animate camera
  void _animateToPosition(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, 15),
    );
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      state = state.copyWith(isLoading: true);

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permission denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permission denied forever';
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      state = state.copyWith(selectedLocation: currentLatLng);
      _addMarker(currentLatLng);
      _animateToPosition(currentLatLng);
    } catch (e) {
      log("Error getting location: ${e.toString()}");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Update location API call
  /*Future<bool> updateLocation() async {
    log("🔑 The access token is: ${state.accessToken}");

    if (state.accessToken == null) {
      log("❌ Access token is null!");
      state = state.copyWith(
        errorMessage: "Authentication token is missing",
      );
      return false;
    }

    state = state.copyWith(
      isUpdatingLocation: true,
      locationUpdateSuccess: false,
      errorMessage: null,
    );

    try {
      var response = await networkCaller.postRequest(
        AppUrl.updateLocation,
        body: {
          "latitude": state.selectedLocation.latitude,
          "longitude": state.selectedLocation.longitude,
        },
        token: state.accessToken,
      );

     if (response.isSuccess) {
        log("✅ Location update successful: ${response.responseData}");
        state = state.copyWith(
          isUpdatingLocation: false,
          locationUpdateSuccess: true,
        );
        return true;
      } else {
        ///log("❌ Location update failed: ${response.responseData}");
        state = state.copyWith(
          isUpdatingLocation: false,
          errorMessage: "Failed to update location",
        );
        return false;
      }
    } catch (e) {
      log("❌ Exception updating location: ${e.toString()}");
      state = state.copyWith(
        isUpdatingLocation: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }*/

  void confirmLocation() {
    //updateLocation();
  }
}

// ADD THIS PROVIDER DECLARATION AT THE END
final allowAccessProvider =
StateNotifierProvider<AllowAccessNotifier, AllowAccessState>(
      (ref) => AllowAccessNotifier(),
);