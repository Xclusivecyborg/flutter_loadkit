import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'custom_tweens/delay_tween.dart';

enum RotationStyle { inward, outward }

class RotatingArc extends StatefulWidget {
  const RotatingArc({
    super.key,
    this.controller,
    this.size = 100,
    this.strokeWidth,
    this.stokeStyle = PaintingStyle.stroke,
    this.rotationStyle = RotationStyle.inward,
  });
  final AnimationController? controller;
  final double size;

  final double? strokeWidth;
  final PaintingStyle stokeStyle;
  final RotationStyle rotationStyle;
  @override
  State<RotatingArc> createState() => _RotatingArcState();
}

class _RotatingArcState extends State<RotatingArc>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ??
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        ))
      ..addListener(() {
        setState(() {
          if (_controller.isCompleted) {
            _controller2.forward();
          }
        });
      });
    _controller2 = (AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    ))
      ..addListener(() async {
        if (_controller2.isCompleted) {
          await Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _controller2.reset();
              _controller
                ..reset()
                ..forward();
            }
          });
        }
      });
    _animation = Tween<double>(begin: math.pi, end: 0).animate(_controller2)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller2.dispose();
    super.dispose();
  }

  List<double> _getBeginAndEnd({
    required RotationStyle rotationStyle,
    int index = 0,
  }) {
    switch (rotationStyle) {
      case RotationStyle.inward:
        return [
          index == 0 ? math.pi * 2 : 0,
          index == 0 ? 0 : math.pi * 2,
        ];

      case RotationStyle.outward:
        return [
          0,
          math.pi * 2,
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(2, (i) {
        return Center(
          child: SizedBox.fromSize(
            size: Size.fromRadius(
              widget.size * .4 * math.sqrt1_2,
            ),
            child: Transform.rotate(
              alignment: Alignment.center,
              angle: Tween<double>(
                begin: _getBeginAndEnd(
                  rotationStyle: widget.rotationStyle,
                  index: i,
                ).first,
                end: _getBeginAndEnd(
                  rotationStyle: widget.rotationStyle,
                  index: i,
                ).last,
              ).animate(_controller).value,
              child: ScaleTransition(
                scale: DelayTween(begin: .5, end: 1, delay: 1)
                    .animate(_controller),
                child: CustomPaint(
                  painter: _ArcPaint(
                    color: Colors.black,
                    style: widget.stokeStyle,
                    startAngle:
                        i == 0 ? math.pi * 0.5 : math.pi + math.pi * 0.5,
                    sweepAngle: math.pi,
                    radians: _animation.value,
                    index: i,
                    strokeWidth: widget.strokeWidth ?? 2,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ArcPaint extends CustomPainter {
  final double radians, strokeWidth, startAngle, sweepAngle;
  final Color color;
  final PaintingStyle style;
  final int index;
  _ArcPaint({
    required this.radians,
    required this.startAngle,
    required this.sweepAngle,
    this.color = Colors.black,
    this.style = PaintingStyle.fill,
    required this.strokeWidth,
    required this.index,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;

    final radius = math.min(centerX, centerY);
    final centerOffset = Offset(
      index.isEven
          ? centerX - ((radius * 0.2) * radians)
          : centerX + ((radius * 0.2) * radians),
      centerY,
    );
    final rect = Rect.fromCircle(center: centerOffset, radius: radius);
    final arcPaint = Paint()
      ..color = color
      ..style = style
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
