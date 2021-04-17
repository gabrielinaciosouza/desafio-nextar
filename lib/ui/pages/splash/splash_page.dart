import 'package:desafio_nextar/ui/mixins/mixins.dart';
import 'package:flutter/material.dart';

import 'splash_presenter.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  final SplashPresenter presenter;

  SplashPage({required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Builder(builder: (context) {
        handleNavigation(presenter.navigateToStream, clear: true);
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
