import 'package:flutter/material.dart';
import 'package:flutter_load_kit/src/custom_tweens/custom_tween.dart';
import 'dart:math' as math;

class LoadKitFoldingSquares extends StatefulWidget {
  const LoadKitFoldingSquares({
    super.key,
    this.controller,
    this.borderColor = Colors.black,
    this.fillColor = Colors.transparent,
    this.size = 50.0,
  });
  final AnimationController? controller;
  final Color borderColor, fillColor;
  final double size;
  @override
  State<LoadKitFoldingSquares> createState() => _LoadKitFoldingSquaresState();
}

class _LoadKitFoldingSquaresState extends State<LoadKitFoldingSquares>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<double> _getScales() {
    List<double> scales = [];
    double value = 0.0;
    for (int i = 0; i < 5; i++) {
      scales.add(value += 0.2);
    }

    return scales;
  }

  bool isSwitching = false;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          vsync: this,
          duration: const Duration(seconds: 1),
        )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..forward();
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
          return Center(
            child: Stack(
              children: List.generate(
                5,
                (index) {
                  return Transform.scale(
                    scale: CustomTween(
                      begin: -1,
                      end: 1,
                      delay: _getScales()[index],
                    ).animate(_controller).value,
                    child: _buildSquares(index),
                  );
                },
              ),
            ),
          );
        });
  }

  Widget _buildSquares(int index) => Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.borderColor,
          ),
          color: widget.fillColor,
        ),
      );
}

