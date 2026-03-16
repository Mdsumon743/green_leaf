import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;

  // Default location (adjust to your business location)
  final LatLng _center = const LatLng(52.0406, -0.7594); // Milton Keynes area

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ================= Background Images =================
          Column(
            children: [
              /// Top Background
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.visitBackground),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              /// Bottom Background
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.homeBackground),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// ================= Overlay =================
          Column(
            children: [
              Container(
                height: 200.h,
                color: AppColor.primary.withValues(alpha: 0.7),
              ),
              Expanded(
                child: Container(
                  color: Colors.white.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),

          /// ================= Content =================
          SafeArea(
            child: Column(
              children: [
                /// ================= Header =================
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CustomText(
                        text: "Google Review",
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60.h),

                /// ================= Content Card =================
                Expanded(
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          /// ================= Google Map =================
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                              child: GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _center,
                                  zoom: 11.0,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId('business_location'),
                                    position: _center,
                                    infoWindow: const InfoWindow(
                                      title: 'Saunders Gradening Service',
                                    ),
                                  ),
                                },
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                mapToolbarEnabled: false,
                              ),
                            ),
                          ),

                          /// ================= Business Info Card =================
                          Container(
                            margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: AppColor.containerBorder,
                                width: 1.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// Business Name
                                CustomText(
                                  text: "Saunders Gradening Service",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.textBody,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 12.h),

                                /// Rating & Reviews
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "4.5",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.textBody,
                                    ),
                                    SizedBox(width: 8.w),
                                    Row(
                                      children: List.generate(
                                        5,
                                            (index) => Icon(
                                          Icons.star,
                                          color: const Color(0xFFFFC107),
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    CustomText(
                                      text: "60 Review",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textBody.withValues(alpha: 0.6),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),

                                /// View Larger Map Button
                                GestureDetector(
                                  onTap: () {
                                    // Open full map or navigate to larger map view
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        color: AppColor.primary,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 6.w),
                                      CustomText(
                                        text: "View larger map",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
