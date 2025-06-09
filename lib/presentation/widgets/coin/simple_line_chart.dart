import 'package:flutter/material.dart';

class SimpleLineChart extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    final path =
        Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width * 0.2, size.height * 0.7)
          ..lineTo(size.width * 0.4, size.height * 0.3)
          ..lineTo(size.width * 0.6, size.height * 0.5)
          ..lineTo(size.width * 0.8, size.height * 0.4)
          ..lineTo(size.width, size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
