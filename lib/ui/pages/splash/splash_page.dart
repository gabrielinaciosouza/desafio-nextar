import 'package:desafio_nextar/ui/mixins/mixins.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'splash_presenter.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  final SplashPresenter presenter;

  SplashPage({required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    return Scaffold(
      body: Builder(builder: (context) {
        handleNavigation(presenter.navigateToStream, clear: true);
        return Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset('lib/ui/assets/splash_animation.json')),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.transparent),
              )
            ],
          ),
        );
      }),
    );
  }
}
