import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'home_presenter.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import '../../pages/home/components/components.dart';

class HomePage extends StatelessWidget with LoadingManager, NavigationManager {
  final HomePresenter presenter;

  HomePage({required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.loadProducts();
    return Scaffold(
      body: InheritedProvider(
        create: (context) => presenter,
        child: Builder(
          builder: (context) {
            handleLoading(context, presenter.isLoadingStream);
            handleNavigation(presenter.navigateToStream);
            return StreamBuilder<List<ProductViewModel>?>(
              stream: presenter.productsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return HomeEmptyList();
                  } else {
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
                                  height:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                                ElevatedButton(
                                  onPressed: presenter.goToNewProduct,
                                  child: Text(R.strings.newProduct),
                                ),
                                HomeAvatar(presenter: presenter),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                ),
                                HomeTitle(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .08,
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
                }
                return HomeErrorWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
