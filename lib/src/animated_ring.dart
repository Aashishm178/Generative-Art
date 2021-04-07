import 'package:flutter/material.dart';
import 'package:generative_art/src/particle.dart';
import 'package:generative_art/utils/utils.dart' as utils;

class AnimatedRing extends StatefulWidget {
  final int noOfRings;
  final double speed;
  final Color color;
  final double maxRadius;
  final Offset startPosition;
  final double minRadius;
  final Widget child;

  AnimatedRing(
      {this.noOfRings,
      this.speed,
      this.color,
      this.startPosition,
      this.minRadius,
      this.maxRadius,
      this.child})
      : assert(
          child != null,
          noOfRings != null,
        );

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
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            if (_particles.isEmpty) {
              List.generate(
                  widget.noOfRings,
                  (_) => _particles.add(RingParticle(
                        color: widget.color ?? utils.randomColor(),
                        speed: widget.speed ?? utils.randomNumber(2),
                        radius: widget.minRadius ?? utils.randomNumber(5),
                        maxRadius: widget.maxRadius ?? utils.randomNumber(25),
                        offset: widget.startPosition ??
                            Offset(utils.randomNumber(1000),
                                utils.randomNumber(1000)),
                      )));
            }
            _particles.forEach((element) {
              double newRadius =
                  element.radius + _stepper(element.radius, element.maxRadius);
              if (newRadius >= element.maxRadius ||
                  element.maxRadius - newRadius < 0.5) {
                _particles.remove(element);
                _particles.add(RingParticle(
                  color: element.color ?? utils.randomColor(),
                  speed: element.speed ?? utils.randomNumber(5),
                  radius: element.radius ?? utils.randomNumber(5),
                  maxRadius: element.maxRadius ?? utils.randomNumber(10),
                  offset: Offset(
                    utils.randomNumber(1000),
                    utils.randomNumber(1000),
                  ),
                ));
              }
            });
          });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _particles?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (_, child) {
          return CustomPaint(
            child: child,
            painter: RingPainter(
              particles: _particles,
            ),
          );
        });
  }
}

double _stepper(double min, double max) {
  return (max - min) / 100;
}

class RingPainter extends CustomPainter {
  List<RingParticle> particles;
  RingPainter({this.particles});
  @override
  void paint(Canvas canvas, Size size) {
    //Updation
    particles.forEach((element) {
      if (element.radius < element.maxRadius) {
        element.radius += _stepper(element.radius, element.maxRadius);
      }
    });

    //Inflation
    particles.forEach((element) {
      Paint paint = Paint()
        ..color = element.color
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(element.offset, element.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RingParticle extends Particle {
  final double maxRadius;
  RingParticle({
    Color color,
    Offset center,
    double speed,
    double theta,
    Offset offset,
    double radius,
    this.maxRadius,
  }) : super(color, center, speed, theta, offset, radius);
}
