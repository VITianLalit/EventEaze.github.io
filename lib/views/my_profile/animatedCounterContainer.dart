import 'package:flutter/material.dart';

class AnimatedCounterContainer extends StatefulWidget {
  final int endValue;
  final Duration duration;

  AnimatedCounterContainer({
    required this.endValue,
    this.duration = const Duration(seconds: 2),
  });

  @override
  _AnimatedCounterContainerState createState() => _AnimatedCounterContainerState();
}

class _AnimatedCounterContainerState extends State<AnimatedCounterContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: widget.endValue).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Color(0xFFA1DD70), Color(0xFF6B8A7A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${_animation.value}',
          style: TextStyle(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 3,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}