import 'package:flutter/material.dart';

class FadeInTransition extends StatefulWidget {
  final Key key;
  final Widget child;
  final Duration duration;
  final double distance;

  FadeInTransition({
    this.key,
    @required
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.distance = 100
  }) : super(key: key);

  @override
  _FadeInTransitionState createState() => _FadeInTransitionState();
}

class _FadeInTransitionState extends State<FadeInTransition>  
with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, widget.distance - widget.distance * _animationController.value),
          child: AnimatedOpacity(
            opacity: _animationController.value,
            duration: widget.duration,
            child: child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}