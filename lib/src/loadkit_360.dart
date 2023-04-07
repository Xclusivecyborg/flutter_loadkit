import 'package:flutter/material.dart';

import 'dart:math' as math;

class LoadKit360 extends StatefulWidget {
  const LoadKit360({
    super.key,
    this.color = Colors.black,
    this.size = 50.0,
    this.controller,
    this.gradient,

    this.style = PaintingStyle.fill,
    
  }) ;
  final Color color;
  final double size;
  final AnimationController? controller;
  final Gradient? gradient;
  final PaintingStyle style;

  @override
  State<LoadKit360> createState() => _LoadKit360State();
}

class _LoadKit360State extends State<LoadKit360>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = widget.controller ??
        AnimationController(
            vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

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
    return Center(
      child: SizedBox.fromSize(
        size: Size.fromRadius(widget.size * 0.5),
        child: Transform.rotate(
          angle: _animation.value,
          child: CustomPaint(
            painter: _Paint360(
              strokeWidth: 2,
              style: widget.style,
              gradient: widget.gradient,
            ),
            child: SizedBox.fromSize(size: const Size.square(50)),
          ),
        ),
      ),
    );
  }
}

class _Paint360 extends CustomPainter {
  final Gradient? gradient;
  final double strokeWidth;
  final PaintingStyle style;
  _Paint360({
    this.gradient,
    required this.strokeWidth,
    required this.style,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(size.width, size.height);
    final rect = Rect.fromPoints(Offset.zero, offset);
    final arcPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = style
      ..shader = gradient?.createShader(rect);

    final circlePaint = Paint()
      ..strokeWidth = 3
      ..color = gradient?.colors.first ?? Colors.black
      ..style = style;
    const count = 4;
    for (var i = 0; i < count; i++) {
      canvas.drawArc(
        rect,
        0 + (i * math.pi / (count / 2)),
        getRadians(75),
        true,
        arcPaint,
      );
    }

    canvas.drawCircle(
      rect.center,
      math.min(offset.dx, offset.dy) / 4,
      circlePaint,
    );
  }

  double getRadians(double angle) => math.pi / 180 * angle;
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
