import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'home_presenter.dart';
import '../../mixins/mixins.dart';
import '../../pages/home/components/components.dart';

class HomePage extends StatelessWidget with LoadingManager, NavigationManager {
  final HomePresenter presenter;

  HomePage({required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.loadProducts();
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          handleNavigation(presenter.navigateToStream);
          return StreamBuilder<List<dynamic>?>(
            stream: presenter.productsStream,
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
                            ElevatedButton(
                              onPressed: presenter.goToNewProduct,
                              child: Text(R.strings.newProduct),
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
                              productViewModel:
                                  snapshot.data as List<ProductViewModel>,
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
