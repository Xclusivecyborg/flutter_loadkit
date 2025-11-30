import 'dart:async';

import 'package:flutter/material.dart';

class LoadkitAligningSquare extends StatefulWidget {
  const LoadkitAligningSquare({
    super.key,
    this.size = 30.0,
    this.color = Colors.white,
    this.borderColor,
    this.backgroundColor = Colors.black,
    this.duration = const Duration(milliseconds: 400),
  });
  final double size;
  final Color? color, borderColor, backgroundColor;
  final Duration duration;

  @override
  State<LoadkitAligningSquare> createState() => _LoadkitAligningSquareState();
}

class _LoadkitAligningSquareState extends State<LoadkitAligningSquare> {
  Alignment _alignment = Alignment.topLeft;
  Timer? _timer;

  void getNextAlignMent() {
    final List<Alignment> alignments = [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomRight,
      Alignment.bottomLeft,
    ];
    final nextIndex = (alignments.indexOf(_alignment) + 1) % alignments.length;

    setState(() {
      if (nextIndex == alignments.length) {
        _alignment = alignments[0];
      } else {
        _alignment = alignments[nextIndex];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, (timer) {
      getNextAlignMent();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.red,
        ),
        height: widget.size,
        width: widget.size,
        child: AnimatedAlign(
          duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 5),
          alignment: _alignment,
          child: Container(
            height: widget.size * 0.5,
            width: widget.size * 0.5,
            color: widget.color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
