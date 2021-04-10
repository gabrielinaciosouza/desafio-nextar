import 'package:flutter/material.dart';

import '../components/components.dart';

class MobileLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginHeader(
                        constraints: constraints,
                        spacingSize: 0.1,
                      ),
                      LoginForm(
                        margin: 0,
                        constraints: constraints,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
