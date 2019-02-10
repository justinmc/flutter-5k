import 'package:flutter_test/flutter_test.dart';

import 'package:fivek/earth_orbit.dart';

void main() {
  group('Orbit', () {
    test('timeToAngle', () {
      expect(moon.timeToAngle(1), moreOrLessEquals(0.229967985769));
    });

    group('getLocation', () {
      test('quadrant 1', () {
        final location = moon.getLocation(1);
        const answer = Offset(394727.3151549793, 92409.45119705898);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 2', () {
        final location = moon.getLocation(10);
        const answer = Offset(-270011.503319188, 302395.35061788256);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 3', () {
        final location = moon.getLocation(18);
        const answer = Offset(-219777.9242735727, -340656.4603849452);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('quadrant 4', () {
        final location = moon.getLocation(24);
        const answer = Offset(292742.0153858556, -280448.34181686206);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('zeros', () {
        final Offset location = moon.getLocation(0);
        final Offset answer = Offset(moon.orbitR, 0);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
      test('around once', () {
        final Offset location = moon.getLocation(moon.orbitT);
        final Offset answer = Offset(moon.orbitR, 0);
        expect(location.dx, moreOrLessEquals(answer.dx));
        expect(location.dy, moreOrLessEquals(answer.dy));
      });
    });
  });
}
