import 'package:flutter/material.dart';

class SplashItem extends StatefulWidget {
  final String? image;

  SplashItem({this.image});

  @override
  _SplashItemState createState() => _SplashItemState();
}

class _SplashItemState extends State<SplashItem> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: 1.2).animate(_animationController!);
    _animationController?.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ScaleTransition(
          scale: _animation!,
          child: Image.asset(
            widget.image!,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
