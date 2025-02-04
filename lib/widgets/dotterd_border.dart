import 'package:bank_sathi/Helpers/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/src/dash_path.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double strokeWidth;
  final Color color;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;

  DottedBorder({
    required this.child,
    this.color = ColorUtils.greylight,
    this.strokeWidth = 1,
    this.borderType = BorderType.Rect,
    this.dashPattern = const <double>[3, 1],
    this.padding = const EdgeInsets.all(2),
    this.radius = const Radius.circular(0),
  }) {
    assert(child != null);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _DashPainter(
              strokeWidth: strokeWidth,
              radius: radius,
              color: color,
              borderType: borderType,
              dashPattern: dashPattern,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}
enum BorderType { Circle, RRect, Rect, Oval }
class _DashPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final BorderType borderType;
  final Radius radius;
  _DashPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[3, 1],
    this.color = ColorUtils.black,
    this.borderType = BorderType.Rect,
    this.radius = const Radius.circular(0),
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;
    Path _path  = _getPath(size);
    canvas.drawPath(_path, paint);
  }

  Path _getPath(Size size) {
    Path path;
    switch (borderType) {
      case BorderType.Circle:
        path = _getCirclePath(size);
        break;
      case BorderType.RRect:
        path = _getRRectPath(size, radius);
        break;
      case BorderType.Rect:
        path = _getRectPath(size);
        break;
      case BorderType.Oval:
        path = _getOvalPath(size);
        break;
    }
    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }
  Path _getCirclePath(Size size) {
    double w = size.width;
    double h = size.height;
    double s = size.shortestSide;
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            w > s ? (w - s) / 2 : 0,
            h > s ? (h - s / 2) : 0,
            s,
            s,
          ),
          Radius.circular(s / 2),
        ),
      );
  }
  Path _getRRectPath(Size size, Radius radius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          radius,
        ),
      );
  }
  Path _getRectPath(Size size) {
    return Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }
  Path _getOvalPath(Size size) {
    return Path()
      ..addOval(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }
  @override
  bool shouldRepaint(_DashPainter oldDelegate) {
    return oldDelegate.strokeWidth != this.strokeWidth ||
        oldDelegate.color != this.color ||
        oldDelegate.dashPattern != this.dashPattern ||
        oldDelegate.borderType != this.borderType;
  }
}