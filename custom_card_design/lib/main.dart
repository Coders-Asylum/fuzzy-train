import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Card Design',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.amber.withOpacity(0.4),
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    return Container(
        color: Colors.amber,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            elevation: 10.0,
            child: Container(
              width: 300.0,
              height: 400.0,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // This will hold the Image in the back ground:
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.pink[100]),
                  ),
                  // This is the Custom Shape Container
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: Container(
                      color: Colors.red,
                      child: CustomPaint(
                        painter: CustomContainerShapeBorder(
                          height: 100.0,
                          width: 300.0,
                          radius: 50.0,
                        ),
                      ),
                    ),
                  ),
                  // This Holds the Widgets Inside the the custom Container;
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      height: 80.0,
                      width: 260.0,
                      child: Center(
                        child: Text(
                          'Content here',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

/// The {CustomContainerShapeBorder} should be reactibe with different sizes,
/// If it isn't then chamge the offset values.
class CustomContainerShapeBorder extends CustomPainter {
  final double height;
  final double width;
  final Color fillColor;
  final double radius;

  CustomContainerShapeBorder({
    this.height: 400.0,
    this.width: 300.0,
    this.fillColor: Colors.white,
    this.radius: 50.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    path.moveTo(0.0, -radius);
    path.lineTo(0.0, -(height - radius));
    path.conicTo(0.0, -height, radius, -height, 1);
    path.lineTo(width - radius, -height);
    path.conicTo(width, -height, width, -(height + radius), 1);
    path.lineTo(width, -(height - radius));
    path.lineTo(width, -radius);

    path.conicTo(width, 0.0, width - radius, 0.0, 1);
    path.lineTo(radius, 0.0);
    path.conicTo(0.0, 0.0, 0.0, -radius, 1);
    path.close();
    canvas.drawPath(path, Paint()..color = fillColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
