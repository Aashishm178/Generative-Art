import 'dart:ui';

abstract class Particle {
  final Color color;
  final Offset center;
  final double radius;
  final double speed;
  final double theta;
  final Offset offset;
  Particle(this.color, this.center, this.speed, this.theta, this.offset,
      this.radius);
}
