

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/global/custom_button.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/utils/app_color.dart';

import '../provider/allow_access_provider.dart';

class AllowAccessScreen extends ConsumerStatefulWidget {
  const AllowAccessScreen({super.key});

  @override
  ConsumerState<AllowAccessScreen> createState() => _AllowAccessScreenState();
}

class _AllowAccessScreenState extends ConsumerState<AllowAccessScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Get token from AuthService (already saved during OTP verification)
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      final accessToken = AuthService.token;
      if (accessToken != null) {
        ref.read(allowAccessProvider.notifier).setAccessToken(accessToken);
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(allowAccessProvider);
    final controller = ref.read(allowAccessProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50.h),

            // Circular map
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 280.h,
                    width: 280.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withValues(alpha: 0.15),
                    ),
                  ),
                  Container(
                    height: 250.h,
                    width: 250.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withValues(alpha: 0.15),
                    ),
                  ),
                  ClipOval(
                    child: SizedBox(
                      height: 230.h,
                      width: 230.w,
                      child: GoogleMap(
                        onMapCreated: controller.setMapController,
                        onTap: controller.onMapTapped,
                        initialCameraPosition: CameraPosition(
                          target: state.selectedLocation,
                          zoom: 15,
                        ),
                        markers: state.markers,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                      ),
                    ),
                  ),
                  if (state.isLoading)
                    Container(
                      height: 200.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.3),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            TextButton.icon(
              onPressed: controller.getCurrentLocation,
              icon: const Icon(Icons.my_location, color: Colors.green),
              label: Text(
                'Use Current Location',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade800,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Bottom container
            Container(
              height: 297.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    'Select Your Location',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBody,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Lat: ${state.selectedLocation.latitude.toStringAsFixed(4)}, '
                        'Lng: ${state.selectedLocation.longitude.toStringAsFixed(4)}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Tap on the map to select your location\nor use your current location",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  state.isUpdatingLocation
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomButton(
                      text: "Confirm Location",
                      onPressed: () async {
                        context.push('/profileSetUp');
                        /*final success = await controller.updateLocation();
                        if (success && context.mounted) {
                          // ✅ Navigate without passing token
                          context.go('/profileSetUp');
                        } else if (!success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.errorMessage ??
                                    'Failed to update location',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }*/
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}