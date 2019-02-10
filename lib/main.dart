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
      end: 1,
    ).animate(_controller);
    _controller.duration = Duration(milliseconds: 100); // 10 days per second
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
        _time = _time.floor() + _animation.value;
      });
    });
    _controller.forward();
  }

  @override
  Widget build (BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final BoardPainter painter = BoardPainter(screenSize: screenSize, time: _time);

    final DateTime date = DateTime.now().add(Duration(days: _time.toInt()));

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          CustomPaint(
            size: Size.infinite,
            painter: painter,
          ),
          Positioned(
            top: 50,
            child: Text('${date.year}.${date.month}.${date.day}'),
          ),
        ],
      ),
      /*
         // TODO date selector?
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'ok',
        child: Icon(Icons.add),
      ),
      */
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
    // TODO create some master Scale based on the screen size to km
    const double SUN_RADIUS_PX = 50;
    const double SCALE = SUN_RADIUS_PX / SUN_RADIUS;
    const double SIZE_FAKE_FACTOR = 10;
    const double D_FAKE_FACTOR = 0.01;

    final Paint sunPaint = Paint()..color = Colors.yellow;
    final Paint earthPaint = Paint()..color = Colors.blue;
    final Paint moonPaint = Paint()..color = Colors.white;

    final Offset sunLocation = Offset(
      this.screenSize.width / 2,
      this.screenSize.height / 2,
    );
    canvas.drawCircle(sunLocation, SUN_RADIUS_PX, sunPaint);

    // TODO that maxA should be the actual proportional distance from the sun
    //Scale earthScale = Scale(maxA: 100, maxB: earth.orbitR);
    Scale earthScale = Scale(maxA: earth.orbitR * SCALE * D_FAKE_FACTOR, maxB: earth.orbitR);
    Offset earthLocationRaw = earth.getLocation(time);
    final Offset earthLocation = earthScale.bToAOffset(earthLocationRaw) + sunLocation;
    canvas.drawCircle(earthLocation, earth.r * SCALE * SIZE_FAKE_FACTOR, earthPaint);

    // TODO that maxA should be the actual proportional distance from earth
    Scale moonScale = Scale(maxA: 20, maxB: moon.orbitR);
    Offset moonLocationRaw = moon.getLocation(time);
    Offset moonLocation = moonScale.bToAOffset(moonLocationRaw) + earthLocation;
    canvas.drawCircle(moonLocation, moon.r * SCALE * SIZE_FAKE_FACTOR, moonPaint);
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    return time != oldDelegate.time;
  }
}
