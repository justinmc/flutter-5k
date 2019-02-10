import 'dart:math' as math;
import 'package:flutter/material.dart';

class Body {
  Body({
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
    if (orbitT == 0) {
      return Offset.zero;
    }
    final angle = timeToAngle(days);
    return Offset(
      orbitR * math.cos(angle),
      orbitR * math.sin(angle),
    );
  }
}
final Body moon = Body(orbitT: 27.322, orbitR: 405400, r: 1737.1);
final Body earth = Body(orbitT: 365.256363004, orbitR: 149598000, r: 6371);
final Body sun = Body(orbitT: 0, orbitR: 0, r: 696342);
