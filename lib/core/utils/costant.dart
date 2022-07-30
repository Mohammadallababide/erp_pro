import 'package:flutter/material.dart';

class ConstatValues {
  static const List<String> companyJobLevels = [
    'junior',
    'mid_level',
    'senior',
  ];
  static const List<String> deductionTypeList = [
    'loan',
    'tax',
    'attendance',
  ];
  static const Gradient baseGradientColor =
      // LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: <Color>[Colors.purple, Colors.blue]);

      LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
        0.5,
        0.5,
      ],
          colors: [
        Colors.indigo,
        Colors.teal
      ]);
  static const Gradient secGradientColor = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[Colors.teal, Colors.indigo]);
  static Gradient thrGradientColor = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Colors.teal.withOpacity(0.6),
        Colors.indigo.withOpacity(0.6)
      ]);
}
