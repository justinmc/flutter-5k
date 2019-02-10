import 'dart:math' as math;
import 'package:flutter/material.dart';

class Orbit {
  Orbit({
    @required this.period,
    @required this.radius,
  });

  final double period; // days
  final double radius; // km max (apogee)

  // Assuming straight right is 0 radians and 0 days.
  double timeToAngle(double days) {
    final double fraction = (days % period) / period;
    return fraction * 2 * math.pi;
  }

  // Offset from center of orbit
  Offset getLocation(double days) {
    final angle = timeToAngle(days);
    return Offset(
      radius * math.cos(angle),
      radius * math.sin(angle),
    );
  }
}
final Orbit moonOrbit = Orbit(period: 27.322, radius: 405400);
final Orbit earthOrbit = Orbit(period: 365.256363004, radius: 149598000);

class Scale {
  Scale({
    this.maxA,
    this.maxB,
  });

  final double maxA;
  final double maxB;

  aToB(double a) {
    return a * maxB / maxA;
  }

  bToA(double b) {
    return b * maxA / maxB;
  }

  aToBOffset(Offset a) {
    return Offset(aToB(a.dx), aToB(a.dy));
  }

  bToAOffset(Offset b) {
    return Offset(bToA(b.dx), bToA(b.dy));
  }
}
