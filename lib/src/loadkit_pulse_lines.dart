import 'package:flutter/material.dart';
import "dart:math" as math;

class LoadKitPulseLines extends StatefulWidget {
  const LoadKitPulseLines({
    super.key,
    this.size = 50.0,
    required this.color,
    this.strokeWidth = 1,
    this.controller,
    this.lineCount = 360,
  }) : assert(lineCount < 361 || lineCount > 35,
            "lineCount must not be greater than 360 and lineCount must be greater than 35");
  final double size;
  final Color color;
  final double strokeWidth;
  final AnimationController? controller;
  final int lineCount;

  @override
  State<LoadKitPulseLines> createState() => _LoadKitPulseLinesState();
}

class _LoadKitPulseLinesState extends State<LoadKitPulseLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        );
    _animation =
        Tween<double>(begin: -math.pi, end: math.pi).animate(_controller)
          ..addListener(() {
            if (AnimationStatus.completed == _animation.status) {
              _controller.reverse();
            } else if (AnimationStatus.dismissed == _animation.status) {
              _controller.forward();
            }
          });

    _controller.forward();
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
            size: Size.fromRadius(
              widget.size * math.sqrt1_2,
            ),
            child: CustomPaint(
              painter: _StrokePaint(
                lineCount: widget.lineCount,
                strokeWidth: widget.strokeWidth,
                color: widget.color,
                radians: _animation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StrokePaint extends CustomPainter {
  final double radians, strokeWidth;
  final Color color;
  final int lineCount;
  _StrokePaint({
    required this.radians,
    required this.color,
    required this.strokeWidth,
    required this.lineCount,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    final centerOffset = Offset(centerX, centerY);
    final radius = math.min(width, height) / 8;

    final circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    int circle = 360;

    canvas.drawCircle(centerOffset, ((radius * 0.25) * radians), circlePaint);
    for (var i = 0; i < circle; i += (circle / lineCount).round()) {
      final angle = i * math.pi / (circle * 0.5);
      final x = centerOffset.dx - (radius) * math.sin(angle);
      final y = centerOffset.dy - (radius) * math.cos(angle);
      final dx = centerOffset.dx - (radius * radians) * math.cos(angle);
      final dy = centerOffset.dy - (radius * radians) * math.sin(angle);

      canvas.drawLine(Offset(x, y), Offset(dx, dy), circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
