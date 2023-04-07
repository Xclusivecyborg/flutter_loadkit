import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadKitSpinningArcs extends StatefulWidget {
  const LoadKitSpinningArcs({
    super.key,
    this.controller,
    this.size = 50,
    this.duration = const Duration(seconds: 1),
    this.color = Colors.black,
  });
  final AnimationController? controller;
  final double size;
  final Duration duration;
  final Color color;
  @override
  State<LoadKitSpinningArcs> createState() => _LoadKitSpinningArcsState();
}

class _LoadKitSpinningArcsState extends State<LoadKitSpinningArcs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _angle;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration));

    _animation = Tween<double>(begin: 0, end: math.pi).animate(_controller);
    _angle = Tween<double>(begin: 0, end: math.pi * 2).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          2,
          (i) {
            return SizedBox.fromSize(
              size: Size.fromRadius(
                widget.size * .4 * math.sqrt1_2,
              ),
              child: Transform.rotate(
                alignment: Alignment.center,
                angle: _angle.value,
                child: CustomPaint(
                  painter: _ArcPaint(
                    angle: i == 0 ? (math.pi / 2) : (math.pi + math.pi / 2),
                    radians: _animation.value,
                    color: widget.color,
                    paintingStyle: PaintingStyle.stroke,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArcPaint extends CustomPainter {
  final double radians;
  final Color color;
  final double angle;
  final PaintingStyle paintingStyle;
  _ArcPaint({
    required this.radians,
    required this.angle,
    required this.color,
    required this.paintingStyle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width * 0.5;
    final centerY = height * 0.5;
    final centerOffset = Offset(
      centerX,
      centerY,
    );
    final radius = math.min(centerX, centerY);
    final rect = Rect.fromCircle(center: centerOffset, radius: radius);

    final arcPaint = Paint()
      ..color = color
      ..style = paintingStyle
      ..strokeWidth = 2;

    canvas.drawArc(rect, angle, math.pi, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
