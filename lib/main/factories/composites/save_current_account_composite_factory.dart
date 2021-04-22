import '../../factories/usecases/secure_local_save_current_account_factory.dart';

import '../../factories/usecases/usecases.dart';

import '../../../domain/usecases/usecases.dart';
import '../../../main/composites/composites.dart';
import '../../../main/factories/factories.dart';

SaveCurrentAccount makeSaveCurrentAccountComposite() {
  final secure = makeSecureLocalSaveCurrentAccount();
  final local = makeLocalSaveCurrentAccount();
  return SaveCurrentAccountComposite(local: local, secure: secure);
}
