import '../../../factories/composites/composites.dart';
import '../../../factories/factories.dart';

import '../../../../presentation/presenters/presenters.dart';

import '../../../../ui/pages/pages.dart';

HomePresenter makeHomePresenter() => GetxHomePresenter(
      deleteProductByCode: makeLocalDeleteProduct(),
      loadProductsData: makeLocalLoadProducts(),
      logoffSession: makeLogoffComposite(),
    );
