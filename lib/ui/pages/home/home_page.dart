import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'home_presenter.dart';
import '../../helpers/helpers.dart';
import '../../components/components.dart';
import '../../mixins/mixins.dart';
import '../../pages/home/components/components.dart';

class HomePage extends StatelessWidget with LoadingManager, NavigationManager {
  final HomePresenter presenter;

  HomePage({required this.presenter}) {
    presenter.loadProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ResponsiveHeadline6(
                        color: Theme.of(context).primaryColor,
                        text: R.strings.atention,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () => Navigator.of(context).pop())
                    ],
                  ),
                  content: ResponsiveHeadline6(
                    color: Theme.of(context).primaryColorLight,
                    text: R.strings.questionLogoff,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: presenter.logoff,
                      child: ResponsiveHeadline6(
                        color: Theme.of(context).primaryColorLight,
                        text: R.strings.yes,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ResponsiveHeadline6(
              color: Theme.of(context).accentColor,
              text: R.strings.logoff,
            ),
          ),
        ],
      ),
      body: InheritedProvider(
        create: (context) => presenter,
        child: Builder(
          builder: (context) {
            handleLoading(context, presenter.isLoadingStream);
            handleNavigation(presenter.navigateToStream, clear: true);

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
                        HomeProductList()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
