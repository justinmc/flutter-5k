import 'dart:math' as math;
import 'package:flutter/material.dart';

class Body {
  Body({
    @required this.orbitT,
    @required this.orbitR,
    @required this.r,
    @required this.color,
  });

  final double orbitT; // period in days
  final double orbitR; // km average
  final double r; // mean radius in km
  final Color color;

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
final Body sun = Body(orbitT: 0, orbitR: 0, r: 696342, color: Colors.yellow);
final Body mercury = Body(orbitT: 87.969, orbitR: 57909050, r: 2439.7, color: Colors.orange);
final Body venus = Body(orbitT: 224.701, orbitR: 108208000, r: 6051.8, color: Colors.green);
final Body earth = Body(orbitT: 365.256363004, orbitR: 149598000, r: 6371, color: Colors.blue);
final Body moon = Body(orbitT: 27.322, orbitR: 405400, r: 1737.1, color: Colors.white);
final Body mars = Body(orbitT: 686.971, orbitR: 227950000, r: 3389.5, color: Colors.red);
