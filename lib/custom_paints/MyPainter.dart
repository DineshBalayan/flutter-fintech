import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double heightL = size.height;
    double width = size.width;

    Paint paint = Paint();
    paint.color = ColorUtils.black;
    paint.style = PaintingStyle.fill;
    
    
   Path path =Path();
    path.lineTo(width,0);
    path.lineTo(width,height*0.4);
     path.lineTo(width*0.3,height*0.55);
    path.quadraticBezierTo(width*0.07,height*0.6,0,height*0.55);
    path.close();
    canvas.drawPath(path,paint);
      
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}