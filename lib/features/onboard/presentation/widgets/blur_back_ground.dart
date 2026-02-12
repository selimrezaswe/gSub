import 'dart:ui';
import 'package:flutter/material.dart';

class BlurBackGround extends StatelessWidget {
  final Widget child;
  const BlurBackGround({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -30,
          left: 30,
          right: -10,
          child: Image.asset(
            "assets/images/shape.png",
            fit: BoxFit.cover,
            color: Colors.white,
            // height: 120,
            // width: 120,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
