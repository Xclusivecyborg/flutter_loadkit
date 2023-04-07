import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTween extends Tween<double> {
  CustomTween({
    double? begin,
    double? end,
    required this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) => super.lerp(math.sqrt(t - delay) * math.pi) / 2;
  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
