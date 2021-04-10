import 'package:flutter/material.dart';

class ResponsiveHeadline6 extends StatelessWidget {
  final String text;
  final Color color;

  const ResponsiveHeadline6({required this.text, required this.color});

  double fontSize({required double maxWidth, required BuildContext context}) {
    if (maxWidth < 265) {
      return 12;
    }
    if (maxWidth >= 265 && maxWidth < 330) {
      return 14;
    }
    if (maxWidth >= 330 && maxWidth < 410) {
      return 16;
    }
    if (maxWidth >= 410) {
      return 18;
    }
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: fontSize(maxWidth: screenWidth, context: context),
          fontWeight: FontWeight.bold,
          color: color),
    );
  }
}
