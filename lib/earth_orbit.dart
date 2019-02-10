import 'dart:math' as math;
import 'package:flutter/material.dart';

class Planet {
  Planet({
    @required this.orbitT,
    @required this.orbitR,
    @required this.r,
  });

  final double orbitT; // period in days
  final double orbitR; // km max (apogee)
  final double r; // mean radius in km

  // Assuming straight right is 0 radians and 0 days.
  double timeToAngle(double days) {
    final double fraction = (days % orbitT) / orbitT;
    return fraction * 2 * math.pi;
  }

  // Offset from center of orbit
  Offset getLocation(double days) {
    final angle = timeToAngle(days);
    return Offset(
      orbitR * math.cos(angle),
      orbitR * math.sin(angle),
    );
  }
}
final Planet moon = Planet(orbitT: 27.322, orbitR: 405400, r: 1737.1);
final Planet earth = Planet(orbitT: 365.256363004, orbitR: 149598000, r: 6371);
const double SUN_RADIUS = 696342;
