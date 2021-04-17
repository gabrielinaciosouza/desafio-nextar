import 'package:flutter/material.dart';

import '../components/components.dart';
import '../login.dart';

class DesktopLoginScreen extends StatelessWidget {
  final LoginPresenter presenter;

  const DesktopLoginScreen({
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
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
                            presenter: presenter,
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
