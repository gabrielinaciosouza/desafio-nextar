import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import 'components/components.dart';
import 'product.dart';

class ProductPage extends StatelessWidget
    with
        KeyboardManager,
        CardSizeManager,
        LoadingManager,
        UIErrorManager,
        NavigationManager {
  final ProductPresenter presenter;
  ProductPage(this.presenter) {
    presenter.loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: InheritedProvider(
        create: (context) => presenter,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).primaryColorLight),
              onPressed: () => presenter.goToHomePage(),
            ),
          ),
          body: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                handleLoading(context, presenter.isLoadingStream);
                handleMainError(context, presenter.mainErrorStream);
                handleNavigation(presenter.navigateToStream, clear: true);

                return Align(
                  alignment: Alignment.topCenter,
                  child: BaseWidget(builder: (context, sizingInformation) {
                    return ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: cardSize(sizingInformation)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .01,
                            ),
                            StreamBuilder<File?>(
                                stream: presenter.fileStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return AspectRatio(
                                        aspectRatio: 2,
                                        child: Image.file(snapshot.data!));
                                  }
                                  return ResponsiveHeadline6(
                                    color: Theme.of(context).primaryColorLight,
                                    text: R.strings.addPhoto,
                                  );
                                }),
                            SizedBox(
                              height: height * .07,
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                final _platform = CheckPlatform.check();
                                if (_platform.currentPlatform ==
                                    CurrentPlatform.isWeb) {
                                  return await presenter.pickFromDevice();
                                }
                                showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    builder: (context) {
                                      return Container(
                                        height: height * .2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.photo_camera),
                                              title: Text('Câmera'),
                                              onTap: () async => await presenter
                                                  .pickFromCamera()
                                                  .then((value) =>
                                                      Navigator.of(context)
                                                          .pop()),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_album),
                                              title: Text('Galeria'),
                                              onTap: () async => await presenter
                                                  .pickFromDevice()
                                                  .then((value) =>
                                                      Navigator.of(context)
                                                          .pop()),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.photo_camera,
                                size: 42,
                              ),
                              color: theme.primaryColorLight,
                            ),
                            SizedBox(
                              height: height * .07,
                            ),
                            ProductNameInput(),
                            SizedBox(
                              height: height * .02,
                            ),
                            ProductCodeInput(),
                            SizedBox(
                              height: height * .02,
                            ),
                            ProductPriceInput(),
                            SizedBox(
                              height: height * .02,
                            ),
                            ProductStockInput(),
                            SizedBox(
                              height: height * .07,
                            ),
                            ProductButton(),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
