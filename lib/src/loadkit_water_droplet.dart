import 'package:flutter/material.dart';

class LoadKitWaterDroplet extends StatefulWidget {
  const LoadKitWaterDroplet({
    super.key,
    this.size = 50.0,
    this.dropLetColor,
    this.holeColor,
    this.dropLetGradient = const LinearGradient(
      colors: [
        Colors.blueAccent,
        Colors.lightBlueAccent,
        Colors.blue,
        Colors.deepPurpleAccent,
      ],
    ),
  });
  final double size;
  final Color? dropLetColor, holeColor;
  final Gradient? dropLetGradient;

  @override
  State<LoadKitWaterDroplet> createState() => _LoadKitWaterDropletState();
}

class _LoadKitWaterDropletState extends State<LoadKitWaterDroplet>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _waterController;
  late AnimationController _holeController;
  int duration = 1500;
  final ValueNotifier<double> _translation = ValueNotifier<double>(0);

  @override
  void initState() {
    _waterController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _holeController
            ..reset()
            ..forward();
        }
      })
      ..addListener(() {
        if (_waterController.value > (0.6)) {
          setState(() {
            _translation.value += widget.size * 0.02;
          });
        }
      });

    _holeController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _translation.value = 0;
          setState(() {});
          _waterController.reset();
          _waterController.forward();
        }
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_holeController);

    _waterController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _waterController.dispose();
    _holeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SizedBox.fromSize(
            size: Size.fromHeight(widget.size),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: widget.size * 0.7,
                  right: 0,
                  left: 0,
                  child: Container(
                    transform: Matrix4.rotationX(1.4),
                    height: ((widget.size * 0.5) * _animation.value),
                    width: ((widget.size * 0.5) * _animation.value),
                    decoration: BoxDecoration(
                      color: widget.holeColor ?? Colors.black87,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: const Offset(0, 0.7),
                  ).animate(_waterController),
                  child: Center(
                    child: ClipPath(
                        clipper: _ArcClipper(),
                        child: ValueListenableBuilder<double>(
                            valueListenable: _translation,
                            builder: (context, val, child) {
                              return Container(
                                transform: Matrix4.translationValues(
                                    0, -_translation.value, 0),
                                width: (widget.size * 0.45),
                                height: (widget.size * 0.45),
                                decoration: BoxDecoration(
                                  color: widget.dropLetColor,
                                  gradient: widget.dropLetGradient,
                                ),
                              );
                            })),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

enum CircleSide {
  left,
  right,
}

class _ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(size.width * .4, 0);

    path.cubicTo(
      width * 0.5,
      height * 0.25,
      width * 0.24,
      height * 0.55,
      width * 0.23,
      height * 0.7,
    );

    path.cubicTo(
      width * 0.2,
      height * 0.85,
      width * 0.32,
      height,
      width * 0.5,
      height,
    );
    path.cubicTo(
      width * 0.8,
      height,
      width * 0.78,
      height * 0.72,
      width * 0.77,
      height * 0.7,
    );

    path.cubicTo(
      width * 0.77,
      height * 0.56,
      width * 0.5,
      height * 0.25,
      width * 0.4,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
