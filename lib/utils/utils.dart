import 'dart:math';
import 'package:flutter/material.dart';

const double minRadius = 1.0;
Random _random = Random(DateTime.now().millisecondsSinceEpoch);

double getPie() => pi;

Offset displacement(double speed, double theta) =>
    Offset(speed * cos(theta), speed * sin(theta));

double degreeToRadian(double degree) => (degree / 180) * getPie();

double randomNumber(double maxLimit) =>
    _random.nextDouble() * (maxLimit - minRadius) + minRadius;

double randomNumberTwo(double maxLimit, double minLimit) =>
    _random.nextDouble() * (maxLimit - minLimit) + minLimit;

Color randomColor() => Color.fromRGBO(randomNumber(255).toInt(),
    randomNumber(255).toInt(), randomNumber(255).toInt(), minRadius);

double randomRadius(double maxRadius) => randomNumber(maxRadius);
