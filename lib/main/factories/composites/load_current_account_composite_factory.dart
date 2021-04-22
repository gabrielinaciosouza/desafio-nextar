import '../../../main/factories/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../main/composites/composites.dart';
import '../../../main/factories/factories.dart';

LoadCurrentAccount makeLoadCurrentAccountComposite() {
  final secure = makeSecureLocalLoadCurrentAccount();
  final local = makeLocalLoadCurrentAccount();
  return LoadCurrentAccountComposite(local: local, secure: secure);
}
