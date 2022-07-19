import 'package:flutter/material.dart';

class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({
    required this.size,
    Key? key,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  }) : super(key: key);

  final BorderRadiusGeometry borderRadius;
  final Size size;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton> {
  final Duration animationDuration = const Duration(milliseconds: 1500);

  int index = 0;
  bool init = false;

  Color bottomColor = Colors.white10;
  Color topColor = Colors.white24;

  @override
  void initState() {
    super.initState();

    initAnimation();
  }

  void initAnimation() {
    if (!init) {
      init = true;

      Future<dynamic>.delayed(const Duration(milliseconds: 100), () {
        updateColor();
      });
    }
  }

  void updateColor() {
    if (index == 0) {
      setState(() {
        index = 1;

        bottomColor = Colors.white24;
        topColor = Colors.white10;
      });
    } else {
      setState(() {
        index = 0;

        bottomColor = Colors.white10;
        topColor = Colors.white30;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.size.height,
      width: widget.size.width,
      duration: animationDuration,
      onEnd: updateColor,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[bottomColor, topColor],
        ),
      ),
    );
  }
}
