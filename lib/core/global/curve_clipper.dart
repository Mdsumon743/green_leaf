import 'package:flutter/cupertino.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Move to the start point (Top Left)
    path.moveTo(0, 50); // Start 50 pixels down to allow for the curve

    // 2. Create the concave "scoop" curve
    // quadraticBezierTo(controlX, controlY, endX, endY)
    path.quadraticBezierTo(
      size.width / 2, // Control point X (center)
      -20,            // Control point Y (pushed UP to create the scoop)
      size.width,     // End point X (far right)
      50,             // End point Y
    );

    // 3. Draw the rest of the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}