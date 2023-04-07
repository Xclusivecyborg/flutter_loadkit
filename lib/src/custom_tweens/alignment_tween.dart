

import 'package:flutter/material.dart';
import 'dart:math'as math;

class AlignTween extends Tween<Alignment> {
  AlignTween({
    Alignment? begin,
    Alignment? end,
    required this.alignmentDelay,
  }) : super(begin: begin, end: end);

  final double alignmentDelay;

  @override
  Alignment lerp(double t) =>
      super.lerp((math.sin((t - alignmentDelay) * 2 * math.pi) + 1) / 2);
  @override
  Alignment evaluate(Animation<double> animation) => lerp(animation.value);
}