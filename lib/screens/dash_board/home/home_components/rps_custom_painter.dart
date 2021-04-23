import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      //..color = Color.fromARGB(255, 33, 150, 243)
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width * 0.9987500, 0);
    path_0.quadraticBezierTo(
        size.width * 0.4989750, size.height * 0.35, size.width * 0.0012500, 0);
    path_0.quadraticBezierTo(size.width * 0.0009375, 0, 0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
