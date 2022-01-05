import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:flutter/material.dart';

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorUtils.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.2;

    var paint2 = Paint()
      ..color = ColorUtils.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.2, 0);

    path.close();

    final path2 = Path();
    path2.moveTo(size.width * 0.2, 0);
    path2.lineTo(size.width * 0.8, 0);
    path2.lineTo(size.width, size.height * 0.5);
    path2.lineTo(size.width * 0.8, size.height);
    path2.lineTo(size.width * 0.2, size.height);
    path2.lineTo(0, size.height * 0.5);
    path2.lineTo(size.width * 0.2, 0);

    path.close();

    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
