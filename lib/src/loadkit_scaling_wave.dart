import 'package:flutter/material.dart';
import 'custom_tweens/scale_tween.dart';

class LoadKitScalingWave extends StatefulWidget {
  const LoadKitScalingWave({
    super.key,
    this.itemBuilder,
    this.color = Colors.black,
    this.size = 50.0,
    this.itemCount = 7,
    this.controller,
  }) : assert(itemCount > 2, "Item count should not be less than 2");
  final IndexedWidgetBuilder? itemBuilder;
  final Color color;
  final double size;
  final int itemCount;
  final AnimationController? controller;

  @override
  State<LoadKitScalingWave> createState() => _LoadKitScalingWaveState();
}

class _LoadKitScalingWaveState extends State<LoadKitScalingWave>
    with TickerProviderStateMixin {
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

  Widget _buildItem(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(40),
          ),
        );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.itemCount, (i) {
          return SizedBox.fromSize(
            size: Size(widget.size / (widget.itemCount * 0.6), widget.size),
            child: ScaleTransition(
              alignment: Alignment.center,
              scale: OverScaleTween(
                begin: 0,
                end: 1,
                scale: List.generate(widget.itemCount, (index) {
                  int newIndex = index;
                  return (newIndex * 0.06);
                })[i],
              ).animate(_controller),
              child: _buildItem(i),
            ),
          );
        }),
      ),
    );
  }
}
