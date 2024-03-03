import 'dart:async';

import 'package:flutter/material.dart';
class AShapeSpotlight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.transparent, Colors.white, Colors.transparent],
          stops: [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}


// return ShaderMask(
// shaderCallback: (Rect bounds) {
// return LinearGradient(
// colors: [Colors.transparent, Colors.white, Colors.transparent],
// stops: [0.0, 0.5, 1.0],
// ).createShader(bounds);
// },
// child: Container(
// width: double.infinity,
// height: 200,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.black.withOpacity(0.5), Colors.transparent],
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// ),
// ),
// ),
// );
// }