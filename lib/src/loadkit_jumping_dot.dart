import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class LoadkitJumpingDot extends StatefulWidget {
  const LoadkitJumpingDot({
    super.key,
    this.numberOfDots = 12,
    this.size = 30,
    this.duration = const Duration(milliseconds: 300),
    this.dotType = DotType.appearing,
    this.curve,
  });
  final int numberOfDots;
  final double size;
  final Duration duration;
  final DotType dotType;
  final Curve? curve;

  @override
  State<LoadkitJumpingDot> createState() => _LoadkitJumpingDotState();
}

class _LoadkitJumpingDotState extends State<LoadkitJumpingDot> {
  late final double radius = widget.size * 5;
  int index = 0;

  Timer? _timer;

  void _getCurrentTranslation() {
    _timer = Timer.periodic(
      widget.duration,
      (timer) {
        setState(() {
          if (index == widget.numberOfDots - 1) {
            index = 0;
          } else {
            index++;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentTranslation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(radius, radius),
        child: LayoutBuilder(
          builder: (context, c) {
            final size = c.biggest.width * 0.05;

            return Stack(
              alignment: Alignment.center,
              children: [
                ...List.generate(
                  widget.dotType == DotType.appearing ? index : 0,
                  (index) {
                    final double angle =
                        index * (2 * math.pi) / widget.numberOfDots;

                    final offsetMultiplier = (size * (widget.numberOfDots / 3));

                    final double dx = offsetMultiplier * math.cos(angle);

                    final double dy = offsetMultiplier * math.sin(angle);

                    return Container(
                      transform: Matrix4.translationValues(
                        dx,
                        dy,
                        0,
                      ),
                      height: size,
                      width: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    double angle = index * (2 * math.pi) / widget.numberOfDots;
                    final offsetMultiplier =
                        ((radius * 0.05) * (widget.numberOfDots / 3));

                    double dx = offsetMultiplier * math.cos(angle);
                    double dy = offsetMultiplier * math.sin(angle);

                    return AnimatedContainer(
                      curve: widget.curve ??
                          const Split(
                            .51,
                            beginCurve: Curves.ease,
                            endCurve: Curves.elasticOut,
                          ),
                      duration: Duration(
                        milliseconds:
                            (widget.duration.inMilliseconds * 0.4).toInt(),
                      ),
                      transform: Matrix4.translationValues(
                        dx,
                        dy,
                        0,
                      ),
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum DotType { fixed, appearing }
