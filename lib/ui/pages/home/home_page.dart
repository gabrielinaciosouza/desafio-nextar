import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'home.dart';
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
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          return StreamBuilder<List<ProductViewModel>>(
            stream: presenter.loadProductsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(snapshot.error.toString()),
                    ElevatedButton(
                      onPressed: presenter.loadProducts,
                      child: Text(
                        R.strings.reload,
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasData) {
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
                            HomeAvatar(presenter: presenter),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                            ),
                            HomeTitle(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .08,
                            ),
                            HomeProductList(
                              productViewModel: snapshot.data,
                              presenter: presenter,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
