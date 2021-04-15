import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final BoxConstraints constraints;
  final double spacingSize;
  const LoginHeader({
    required this.constraints,
    required this.spacingSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: constraints.maxHeight * .1,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: AspectRatio(
            aspectRatio: 4,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('lib/ui/assets/logo.png'),
            ),
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * spacingSize,
        ),
      ],
    );
  }
}
