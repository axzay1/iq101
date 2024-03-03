import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipeUpAnimation extends StatefulWidget {
  @override
  _SwipeUpAnimationState createState() => _SwipeUpAnimationState();
}

class _SwipeUpAnimationState extends State<SwipeUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _controller.value * 10), // Adjust the offset for desired effect
              child: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white24,
                size: 15,
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _controller.value * 10), // Adjust the offset for desired effect
              child:  Text('Be You!', style: GoogleFonts.oswald(color: Colors.white24, fontSize: 10),)
            );
          },
        ),
      ],
    );
  }
}
