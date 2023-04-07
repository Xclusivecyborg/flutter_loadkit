import 'package:flutter/material.dart';

import 'dart:math' as math;

class LoadKitFilledCircle extends StatefulWidget {
  const LoadKitFilledCircle({
    super.key,
    this.color = Colors.black,
    this.size = 50.0,
    this.controller,
    this.strokeWidth,
    this.strokeStyle = PaintingStyle.fill,
  });
  final Color color;
  final double size;
  final AnimationController? controller;
  final double? strokeWidth;
  final PaintingStyle strokeStyle;
  @override
  State<LoadKitFilledCircle> createState() => _LoadKitFilledCircleState();
}

class _LoadKitFilledCircleState extends State<LoadKitFilledCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = widget.controller ??
        AnimationController(
            vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: math.pi).animate(_controller);

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: SizedBox.fromSize(
              size: Size.fromRadius(widget.size * 0.5),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(_animation.value),
                child: CustomPaint(
                  painter: _FilledPaint(
                    color: Colors.black,
                    strokeStyle: widget.strokeStyle,
                    strokeWidth: widget.strokeWidth ?? 2,
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _FilledPaint extends CustomPainter {
  final Color color;
  final PaintingStyle strokeStyle;
  final double strokeWidth;
  _FilledPaint({
    required this.color,
    required this.strokeStyle,
    required this.strokeWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(size.width, size.height);
    final rect = Rect.fromPoints(Offset.zero, offset);
    final arcPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = strokeStyle;

    for (var i = 0; i < 4; i++) {
      canvas.drawArc(
        rect,
        0 + (i * math.pi / 2),
        getRadians(75),
        false,
        arcPaint,
      );
    }

    canvas.drawCircle(
      rect.center,
      math.min(offset.dx, offset.dy) / 4,
      arcPaint,
    );
  }

  double getRadians(double angle) => math.pi / 180 * angle;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
