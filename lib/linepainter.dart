import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  List<Offset> points;

  LinePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length % 2 == 0) {
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 5.0;

      final circ = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;

      for (int i = 0; i < points.length; i += 2) {
        canvas.drawLine(points[i], points[i + 1], paint);
        canvas.drawCircle(points[i], 5, circ);
        canvas.drawCircle(points[i + 1], 5, circ);
      }
      // canvas.drawCircle(points[points.length - 1], 5, circ);
      // canvas.drawCircle(points[points.length - 2], 5, circ);
      // canvas.drawLine(points[points.length - 2], points[points.length - 1], paint);
    } 
    // else if (points.length > 2) {
    //   final paint = Paint()
    //     ..color = Colors.black
    //     ..strokeWidth = 5.0;

    //   final circ = Paint()
    //     ..color = Colors.blue
    //     ..style = PaintingStyle.fill;
        
    //   for (int i = 0; i < points.length - 1; i += 2) {
    //     canvas.drawLine(points[i], points[i + 1], paint);
        
    //   }
    // }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
