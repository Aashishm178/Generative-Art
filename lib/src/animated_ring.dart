import 'package:flutter/material.dart';
import 'package:generative_art/src/particle.dart';
import 'package:generative_art/utils/utils.dart' as utils;
import 'dart:math' as math;

class AnimatedRing extends StatefulWidget {
  @override
  _AnimatedRingState createState() => _AnimatedRingState();
}

class _AnimatedRingState extends State<AnimatedRing>
    with SingleTickerProviderStateMixin {
  List<RingParticle> _particles = <RingParticle>[];
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    Color ringColor = utils.randomColor();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            if (_particles.isEmpty) {
              List.generate(
                  20,
                  (_) => _particles.add(RingParticle(
                        color: ringColor,
                        theta: utils.randomNumber(2) * math.pi,
                        speed: utils.randomNumber(2),
                        radius: utils.randomNumber(10),
                        center: Offset(
                            utils.randomNumber(100), utils.randomNumber(100)),
                      )));
            }
          });
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RingPainter extends CustomPainter {
  List<RingParticle> particles;
  RingPainter({this.particles});
  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((element) {});
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RingParticle extends Particle {
  RingParticle(
      {Color color,
      Offset center,
      double speed,
      double theta,
      Offset offset,
      double radius})
      : super(color, center, speed, theta, offset, radius);
}
