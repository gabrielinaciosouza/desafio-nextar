import 'package:flutter/material.dart';

import '../components/components.dart';
import '../login.dart';

class TabletLoginScreen extends StatelessWidget {
  final LoginPresenter presenter;

  const TabletLoginScreen({
    required this.presenter,
  });

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
                        spacingSize: 0.05,
                      ),
                      LoginForm(
                        presenter: presenter,
                        constraints: constraints,
                        borderRadius: BorderRadius.circular(30),
                        margin: 0,
                      ),
                      Container(
                        height: constraints.maxHeight * .05,
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
