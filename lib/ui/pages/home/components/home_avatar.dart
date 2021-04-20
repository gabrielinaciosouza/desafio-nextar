import 'package:flutter/material.dart';

class HomeAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CircleAvatar(
        radius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            'lib/ui/assets/avatar.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
