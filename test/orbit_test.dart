import 'package:flutter_test/flutter_test.dart';

import 'package:fivek/earth_orbit.dart';

void main() {
  group('Orbit', () {
    test('timeToAngle', () {
      expect(moonOrbit.timeToAngle(1), moreOrLessEquals(0.229967985769));
    });

    group('getLocation', () {
      test('quadrant 1', () {
        final location = moonOrbit.getLocation(1);
        const answer = Offset(92409.45119705898, -394727.31515497935);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 2', () {
        final location = moonOrbit.getLocation(10);
        const answer = Offset(270011.503319188, 302395.35061788256);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 3', () {
        final location = moonOrbit.getLocation(18);
        const answer = Offset(-340656.4603849452, 219777.92427357272);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 4', () {
        final location = moonOrbit.getLocation(24);
        const answer = Offset(-292742.0153858556, -280448.34181686206);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('zeros', () {
        final Offset location = moonOrbit.getLocation(0);
        final Offset answer = Offset(0, -moonOrbit.radius);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('around once', () {
        final Offset location = moonOrbit.getLocation(moonOrbit.period);
        final Offset answer = Offset(0, -moonOrbit.radius);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
    });
  });

  group('Scale', () {
    test('scale scales between 1 and 100 ok', () {
      Scale scale = Scale(maxA: 1, maxB: 100);

      expect(scale.aToB(0), 0);
      expect(scale.aToB(0.25), 25);
      expect(scale.aToB(0.5), 50);
      expect(scale.aToB(0.75), 75);
      expect(scale.aToB(1), 100);
    });

    test('aToBOffset', () {
      Scale scale = Scale(maxA: 1, maxB: 100);
      expect(scale.aToBOffset(Offset(0, 0)), equals(Offset(0, 0)));
      expect(scale.aToBOffset(Offset(0.25, 0.25)), equals(Offset(25, 25)));
      expect(scale.aToBOffset(Offset(0.5, 0.5)), equals(Offset(50, 50)));
      expect(scale.aToBOffset(Offset(0.75, 0.75)), equals(Offset(75, 75)));
      expect(scale.aToBOffset(Offset(1, 1)), equals(Offset(100, 100)));
    });

    test('bToAOffset', () {
      Scale scale = Scale(maxA: 1, maxB: 100);
      expect(scale.bToAOffset(Offset(0, 0)), equals(Offset(0, 0)));
      expect(scale.bToAOffset(Offset(25, 25)), equals(Offset(.25, .25)));
      expect(scale.bToAOffset(Offset(50, 50)), equals(Offset(.5, .5)));
      expect(scale.bToAOffset(Offset(75, 75)), equals(Offset(.75, .75)));
      expect(scale.bToAOffset(Offset(100, 100)), equals(Offset(1, 1)));
    });
  });
}
