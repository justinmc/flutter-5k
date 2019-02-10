import 'dart:math' as math;
import 'package:flutter/material.dart';

class EarthOrbit {
  EarthOrbit();

}

class Orbit {
  Orbit({
    @required this.period,
    @required this.radius,
  });

  final double period; // days
  final double radius; // km max (apogee)

  // Assuming straight up is 0 radians and 0 days.
  double timeToAngle(double days) {
    final double fraction = (days % period) / period;
    return fraction * 2 * math.pi;
  }

  // Offset from Earth's center
  Offset getLocation(double days) {
    final angle = timeToAngle(days);

    double x;
    double y;
    // Slightly different formulas for quadrants 4-1, respectively.
    if (angle > 3 * math.pi / 2) {
      x = -radius * math.sin(angle - 3 * math.pi / 2);
      y = -math.sqrt(math.pow(radius, 2) - math.pow(x, 2));
    } else if (angle > math.pi) {
      x = -radius * math.sin(angle - math.pi);
      y = math.sqrt(math.pow(radius, 2) - math.pow(x, 2));
    } else if (angle > math.pi / 2) {
      x = radius * math.sin(angle - math.pi / 2);
      y = math.sqrt(math.pow(radius, 2) - math.pow(x, 2));
    } else {
      x = radius * math.sin(angle);
      y = -math.sqrt(math.pow(radius, 2) - math.pow(x, 2));
    }

    return Offset(x, y);
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
