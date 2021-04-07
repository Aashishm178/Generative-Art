import 'package:flutter/material.dart';
import 'package:generative_art/src/particle.dart';
import 'package:generative_art/utils/utils.dart' as utils;

class AnimatedParticle extends StatefulWidget {
  final int noOfParticles;
  final Color color;
  final Offset startPosition;
  final double speed;
  final double theta;
  final double radius;
  final Widget child;

  AnimatedParticle(
      {this.noOfParticles,
      this.color,
      this.startPosition,
      this.child,
      this.speed,
      this.theta,
      this.radius})
      : assert(
          child != null,
          noOfParticles != null,
        );
  @override
  _AnimatedParticleState createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  List<Particle> _listOfParticles = <Particle>[];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        if (_listOfParticles.isEmpty) {
          List.generate(
            widget.noOfParticles,
            (_) => _listOfParticles.add(
              MyParticles(
                color: widget.color ?? utils.randomColor(),
                speed: widget.speed ?? utils.randomNumber(0.5),
                theta:
                    widget.theta ?? utils.randomNumber(2) * 2 * utils.getPie(),
                radius: widget.radius ?? utils.randomRadius(5),
                offset: widget.startPosition ??
                    Offset(utils.randomNumber(1000), utils.randomNumber(1000)),
              ),
            ),
          );
        }
      });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _listOfParticles?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: widget.child,
        animation: _animationController,
        builder: (_, child) {
          return CustomPaint(
            painter: ParticlePainter(
              list: _listOfParticles,
            ),
            child: child,
          );
        });
  }
}

class ParticlePainter extends CustomPainter {
  List<Particle> list;
  ParticlePainter({this.list});
  @override
  void paint(Canvas canvas, Size size) {
    //Updating
    list.forEach((element) {
      final displacement = utils.displacement(element.speed, element.theta);
      var dx = element.offset.dx + displacement.dx;
      var dy = element.offset.dy + displacement.dy;
      if (element.offset.dx < 0 || element.offset.dx > size.width) {
        dx = utils.randomNumber(size.width);
      }
      if (element.offset.dy < 0 || element.offset.dy > size.height) {
        dy = utils.randomNumber(size.height);
      }
      element.offset = Offset(dx, dy);
    });

    //Inflation
    list.forEach((element) {
      Paint paint = Paint()..color = element.color;
      canvas.drawCircle(element.offset, element.radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MyParticles extends Particle {
  MyParticles(
      {Color color,
      Offset center,
      double speed,
      double theta,
      Offset offset,
      double radius})
      : super(color, center, speed, theta, offset, radius);
}
