import 'package:flutter/material.dart';

class ResponsiveHeadline1 extends StatelessWidget {
  final String text;
  final Color color;

  const ResponsiveHeadline1({required this.text, required this.color});

  double fontSize({required double maxWidth, required BuildContext context}) {
    if (maxWidth < 265) {
      return 24;
    }
    if (maxWidth >= 265 && maxWidth < 330) {
      return 34;
    }
    if (maxWidth >= 330 && maxWidth < 410) {
      return 48;
    }
    if (maxWidth >= 410) {
      return 60;
    }
    return 60;
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
