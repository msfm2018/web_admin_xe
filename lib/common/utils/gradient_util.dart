import 'package:flutter/material.dart';







class GradientUtil {
  static LinearGradient _getLinearGradient(Color left, Color right,
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      LinearGradient(
        colors: [
          left.withOpacity(opacity),
          right.withOpacity(opacity),
        ],
        begin: begin,
        end: end,
      );

  static LinearGradient yellowGreen(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.yellow, Colors.green,
          begin: begin, end: end, opacity: opacity);

  static LinearGradient red(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.red, Colors.red,
          begin: begin, end: end, opacity: opacity);

  static LinearGradient yellowBlue(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.yellow, Colors.blue,
          begin: begin, end: end, opacity: opacity);

  static LinearGradient blue(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.lightBlue, Colors.blue.shade400,
          begin: begin, end: end, opacity: opacity);

  static LinearGradient greenRed(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.green, Colors.red,
          begin: begin, end: end, opacity: opacity);

  static LinearGradient greenPurple(
          {begin = AlignmentDirectional.centerStart,
          end = AlignmentDirectional.centerEnd,
          opacity = 1.0}) =>
      _getLinearGradient(Colors.green, Colors.purple,
          begin: begin, end: end, opacity: opacity);
}
