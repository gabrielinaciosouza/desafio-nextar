import 'package:flutter/material.dart';

import '../components/components.dart';

class DesktopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
              print(constraints.biggest.aspectRatio);
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: constraints.maxHeight, maxWidth: 1200),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: constraints.maxHeight * .12,
                        ),
                        SizedBox(
                          height: 490,
                          width: constraints.maxWidth,
                          child: LoginForm(
                            constraints: constraints,
                            borderRadius: BorderRadius.circular(30),
                            margin: 0.1,
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * .12,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
