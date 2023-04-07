import 'package:flutter/material.dart';
import 'dart:math' as math;

class OverScaleTween extends Tween<double> {
  OverScaleTween({
    double? begin,
    double? end,
    required this.scale,
  }) : super(
          begin: begin,
          end: end,
        );

  final double scale;

  @override
  double lerp(double t) => super.lerp((math.log((t - scale) * math.pi) / 2.5));

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
