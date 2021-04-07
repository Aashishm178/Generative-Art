import 'dart:ui';

abstract class Particle {
  Color color;
  Offset center;
  double radius;
  double speed;
  double theta;
  Offset offset;
  Particle(this.color, this.center, this.speed, this.theta, this.offset,
      this.radius);
}
