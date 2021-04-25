import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../mixins/mixins.dart';
import 'components/components.dart';
import 'product.dart';

class ProductPage extends StatefulWidget {
  final ProductPresenter presenter;
  ProductPage(this.presenter);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with
        KeyboardManager,
        CardSizeManager,
        LoadingManager,
        UIErrorManager,
        NavigationManager {
  @override
  void initState() {
    widget.presenter.loadProduct().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: InheritedProvider(
        create: (context) => widget.presenter,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).primaryColorLight),
              onPressed: () => widget.presenter.goToHomePage(),
            ),
          ),
          body: SingleChildScrollView(
            child: Builder(
              builder: (context) {
                handleLoading(context, widget.presenter.isLoadingStream);
                handleMainError(context, widget.presenter.mainErrorStream);
                handleNavigation(widget.presenter.navigateToStream,
                    clear: true);
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
                            ResponsiveHeadline6(
                              color: Theme.of(context).primaryColorLight,
                              text: R.strings.addPhoto,
                            ),
                            SizedBox(
                              height: height * .07,
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
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
