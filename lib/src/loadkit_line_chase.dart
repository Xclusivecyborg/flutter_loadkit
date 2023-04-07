import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_load_kit/src/custom_tweens/alignment_tween.dart';

class LoadKitLineChase extends StatefulWidget {
  const LoadKitLineChase({
    super.key,
    this.controller,
    this.size = 50,
    this.itemBuilder,
    this.itemCount = 5,
    this.color,
  }) : assert(itemCount >= 2, 'itemCount Cannot be less then 2 ');
  final AnimationController? controller;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final int itemCount;
  final Color? color;

  @override
  State<LoadKitLineChase> createState() => _LoadKitLineChaseState();
}

class _LoadKitLineChaseState extends State<LoadKitLineChase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 2),
        );

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
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(
              widget.itemCount,
              (index) => Center(
                child: AnimatedAlign(
                    alignment: AlignTween(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      alignmentDelay: List.generate(
                        widget.itemCount,
                        (ind) => math.sin(ind),
                      )[index],
                    ).animate(_controller).value,
                    duration: const Duration(milliseconds: 100),
                    child: _itemBuilder(
                      index,
                    )),
              ),
            ),
          );
        });
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : SizedBox.fromSize(
          size: Size(widget.size * 0.4, widget.size * 0.15),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.color ?? _getRandomColor(),
            ),
          ),
        );

  Color _getRandomColor() {
    math.Random random = math.Random();
    int alpha = 255;
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    return Color.fromARGB(alpha, red, green, blue);
  }
}
