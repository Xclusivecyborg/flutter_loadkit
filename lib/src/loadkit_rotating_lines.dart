import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'custom_tweens/delay_tween.dart';

class LoadKitRotatingLines extends StatefulWidget {
  const LoadKitRotatingLines({
    super.key,
    this.height = 50.0,
    this.thickness = 1,
    this.color = Colors.black,
    this.animationController,
  });
  final double height;
  final double thickness;
  final Color color;
  final AnimationController? animationController;

  @override
  State<LoadKitRotatingLines> createState() => _LoadKitRotatingLinesState();
}

class _LoadKitRotatingLinesState extends State<LoadKitRotatingLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
    _animation = Tween<double>(begin: 0, end: math.pi * 4).animate(_controller);
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Align(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: _animation.value,
                    child: ScaleTransition(
                      scale: DelayTween(begin: 0.0, end: 3.0, delay: i * .3)
                          .animate(_controller),
                      child: SizedBox.fromSize(
                        size: Size(widget.height * 0.5, widget.thickness),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: widget.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}
