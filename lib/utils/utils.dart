import 'dart:math';
import 'package:flutter/material.dart';

const double minRadius = 1.0;
Random _random = Random();

Offset displacement(double speed, double theta) =>
    Offset(speed * cos(theta), speed * sin(theta));

double degreeToRadian(double degree) => (degree / 180) * pi;

double randomNumber(double maxLimit) =>
    _random.nextDouble() * (maxLimit - minRadius) + minRadius;

Color randomColor() => Color.fromRGBO(randomNumber(255).toInt(),
    randomNumber(255).toInt(), randomNumber(255).toInt(), minRadius);

double randomRadius(double maxRadius) => randomNumber(maxRadius);
