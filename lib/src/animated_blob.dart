import 'package:flutter/cupertino.dart';
import 'package:generative_art/src/particle.dart';
import 'package:generative_art/utils/utils.dart' as utils;

class AnimatedBlob extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final double speed;
  final double theta;
  final int noOfParticles;
  final Color particleColor;
  AnimatedBlob({
    this.child,
    this.particleColor,
    this.speed,
    this.radius,
    this.noOfParticles,
    this.theta,
    this.width = 200.0,
    this.height = 200.0,
  }) : assert(
          child != null,
          noOfParticles != null,
        );

  @override
  _AnimatedBlobState createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob>
    with SingleTickerProviderStateMixin {
  List<BlobParticle> _particles = <BlobParticle>[];
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        //Populate Paricles
        if (_particles.isEmpty) {
          List.generate(
              widget.noOfParticles,
              (_) => _particles.add(
                    BlobParticle(
                      center: Offset(utils.randomNumber(widget.width),
                          utils.randomNumber(widget.height)),
                      color: widget.particleColor ?? utils.randomColor(),
                      speed: widget.speed ?? utils.randomNumber(2.0),
                      theta: widget.theta ??
                          utils.randomNumber(2.0) * utils.getPie(),
                      radius: widget.radius ?? utils.randomNumber(2.0),
                    ),
                  ));
        }
        //Update Particles
        else {}
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
    return CustomPaint(
      painter: BlobPainter(
        particles: _particles,
      ),
      child: widget.child,
    );
  }
}

class BlobPainter extends CustomPainter {
  List<BlobParticle> particles;
  BlobPainter({this.particles});
  @override
  void paint(Canvas canvas, Size size) {
    //Updation
    particles.forEach((element) {});

    //Drawing
    particles.forEach((element) {});
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BlobParticle extends Particle {
  BlobParticle({
    Color color,
    Offset center,
    double speed,
    double theta,
    Offset offset,
    double radius,
  }) : super(color, center, speed, theta, offset, radius);
}
