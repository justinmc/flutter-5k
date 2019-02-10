import 'package:flutter/material.dart';
import 'package:fivek/earth_orbit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: SolarSystem(),
    );
  }
}

class SolarSystem extends StatefulWidget {
  const SolarSystem({Key key}) : super(key: key);

  @override _SolarSystemState createState() => _SolarSystemState();
}
class _SolarSystemState extends State<SolarSystem> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  static const double HEXAGON_RADIUS = 32.0;
  static const double HEXAGON_MARGIN = 1.0;
  static const int BOARD_RADIUS = 8;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: moonOrbit.period,
    ).animate(_controller);
    _controller.duration = Duration(seconds: 2);
    _animation
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..addListener(() {
      setState(() {
        _time = _animation.value;
      });
    });
    _controller.forward();
  }


  @override
  Widget build (BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final BoardPainter painter = BoardPainter(screenSize: screenSize, time: _time);

    return Scaffold(
      body: CustomPaint(
        size: Size.infinite,
        painter: painter,
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  BoardPainter({
    @required this.screenSize,
    @required this.time,
    });

  final Size screenSize;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(
      this.screenSize.width / 2,
      this.screenSize.height / 2,
    );

    final Paint sunPaint = Paint()..color = Colors.yellow;
    final Paint earthPaint = Paint()..color = Colors.blue;
    final Paint moonPaint = Paint()..color = Colors.white;

    canvas.drawCircle(center, 50.0, sunPaint);
    final Offset earthLocation = Offset(200, 200);
    canvas.drawCircle(earthLocation, 10.0, earthPaint);

    Scale scale = Scale(maxA: 20, maxB: moonOrbit.radius);
    Offset moonLocationRaw = moonOrbit.getLocation(time);
    Offset moonLocation = scale.bToAOffset(moonLocationRaw) + earthLocation;
    canvas.drawCircle(moonLocation, 4.0, moonPaint);
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    return time != oldDelegate.time;
  }
}
