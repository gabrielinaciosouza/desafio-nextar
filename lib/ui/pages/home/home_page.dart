import 'package:flutter/material.dart';

import 'home_presenter.dart';
import '../../mixins/mixins.dart';
import '../../pages/home/components/components.dart';

class HomePage extends StatelessWidget with LoadingManager {
  final HomePresenter presenter;

  HomePage({required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.loadProducts();
    return Scaffold(
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    HomeAvatar(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    HomeTitle(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .08,
                    ),
                    HomeProductList()
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
