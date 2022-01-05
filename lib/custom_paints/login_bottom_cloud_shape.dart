import 'package:flutter/material.dart';

class LoginBottomCloudShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7833350, size.height * 0.02591690);
    path_0.lineTo(size.width * 0.7875000, size.height * 0.02591690);
    path_0.cubicTo(
        size.width * 0.7890700,
        size.height * 0.02642899,
        size.width * 0.7906350,
        size.height * 0.02729954,
        size.width * 0.7922050,
        size.height * 0.02731490);
    path_0.arcToPoint(Offset(size.width * 0.8501300, size.height * 0.03724434),
        radius:
            Radius.elliptical(size.width * 0.1911800, size.height * 0.1958029),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.cubicTo(
        size.width * 0.8858000,
        size.height * 0.04922213,
        size.width * 0.9157250,
        size.height * 0.07033562,
        size.width * 0.9411300,
        size.height * 0.09837770);
    path_0.cubicTo(
        size.width * 0.9773650,
        size.height * 0.1383873,
        size.width * 0.9945600,
        size.height * 0.1865033,
        size.width * 0.9983600,
        size.height * 0.2402780);
    path_0.cubicTo(
        size.width * 0.9986900,
        size.height * 0.2449482,
        size.width * 0.9994500,
        size.height * 0.2495826,
        size.width * 1.000010,
        size.height * 0.2542375);
    path_0.lineTo(size.width * 1.000010, size.height * 1.025917);
    path_0.lineTo(0, size.height * 1.025917);
    path_0.lineTo(0, size.height * 0.3594875);
    path_0.cubicTo(
        size.width * 0.001000000,
        size.height * 0.3589754,
        size.width * 0.002165000,
        size.height * 0.3586169,
        size.width * 0.002915000,
        size.height * 0.3578437);
    path_0.cubicTo(
        size.width * 0.01241500,
        size.height * 0.3480167,
        size.width * 0.02257000,
        size.height * 0.3387120,
        size.width * 0.03123000,
        size.height * 0.3281424);
    path_0.cubicTo(
        size.width * 0.05773000,
        size.height * 0.2958398,
        size.width * 0.07203000,
        size.height * 0.2579861,
        size.width * 0.07728500,
        size.height * 0.2164504);
    path_0.cubicTo(
        size.width * 0.07941000,
        size.height * 0.1996333,
        size.width * 0.08158000,
        size.height * 0.1828931,
        size.width * 0.08706000,
        size.height * 0.1667776);
    path_0.cubicTo(
        size.width * 0.09725500,
        size.height * 0.1367947,
        size.width * 0.1150600,
        size.height * 0.1130081,
        size.width * 0.1417550,
        size.height * 0.09662123);
    path_0.cubicTo(
        size.width * 0.1638600,
        size.height * 0.08303547,
        size.width * 0.1881300,
        size.height * 0.07632708,
        size.width * 0.2135000,
        size.height * 0.07295753);
    path_0.cubicTo(
        size.width * 0.2486600,
        size.height * 0.06828214,
        size.width * 0.2837050,
        size.height * 0.06937289,
        size.width * 0.3186450,
        size.height * 0.07479593);
    path_0.arcToPoint(Offset(size.width * 0.3896850, size.height * 0.09212507),
        radius:
            Radius.elliptical(size.width * 0.4475900, size.height * 0.4584131),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.cubicTo(
        size.width * 0.4189900,
        size.height * 0.1018548,
        size.width * 0.4489350,
        size.height * 0.1080306,
        size.width * 0.4797400,
        size.height * 0.1084147);
    path_0.arcToPoint(Offset(size.width * 0.5249850, size.height * 0.1056084),
        radius:
            Radius.elliptical(size.width * 0.3356750, size.height * 0.3437919),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.arcToPoint(Offset(size.width * 0.6040000, size.height * 0.08347074),
        radius:
            Radius.elliptical(size.width * 0.2911750, size.height * 0.2982159),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * 0.6251450,
        size.height * 0.07418142,
        size.width * 0.6457850,
        size.height * 0.06369893,
        size.width * 0.6668300,
        size.height * 0.05415357);
    path_0.cubicTo(
        size.width * 0.7025000,
        size.height * 0.03798175,
        size.width * 0.7396650,
        size.height * 0.02816498,
        size.width * 0.7788900,
        size.height * 0.02730978);
    path_0.cubicTo(
        size.width * 0.7803800,
        size.height * 0.02727906,
        size.width * 0.7818550,
        size.height * 0.02640338,
        size.width * 0.7833350,
        size.height * 0.02591690);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffffffff).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
