import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SolarSystem(),
      /*
      home: Builder(
        builder: (BuildContext context) {
          final Size screenSize = MediaQuery.of(context).size;
          return Transform(
            transform: Matrix4.identity()
              ..translate(screenSize.width / 2, screenSize.height / 2),
            child: SolarSystem(),
          );
        },
      ),
      */
    );
  }
}

class SolarSystem extends StatefulWidget {
  const SolarSystem({Key key}) : super(key: key);

  @override _SolarSystemState createState() => _SolarSystemState();
}
class _SolarSystemState extends State<SolarSystem> {
  static const double HEXAGON_RADIUS = 32.0;
  static const double HEXAGON_MARGIN = 1.0;
  static const int BOARD_RADIUS = 8;

  @override
  Widget build (BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final BoardPainter painter = BoardPainter(screenSize);
    //final Size visibleSize = Size(screenSize.width * 3, screenSize.height * 3);

    return Scaffold(
      body: CustomPaint(
        size: Size.infinite,
        painter: painter,
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  BoardPainter(
    @required this.screenSize,
  );

  final Size screenSize;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(
      this.screenSize.width / 2,
      this.screenSize.height / 2,
    );

    final Paint sunPaint = Paint()..color = Colors.yellow;
    final Paint earthPaint = Paint()..color = Colors.blue;

    canvas.drawCircle(center, 50.0, sunPaint);
    canvas.drawCircle(Offset(100, 100), 10.0, earthPaint);
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) {
    // TODO
    return false;
  }
}
