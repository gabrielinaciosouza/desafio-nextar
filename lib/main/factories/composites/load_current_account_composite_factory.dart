import '../../factories/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../../composites/composites.dart';
import '../../factories/factories.dart';

LoadCurrentAccount makeLoadCurrentAccountComposite() {
  final secure = makeSecureLocalLoadCurrentAccount();
  final local = makeLocalLoadCurrentAccount();
  return LoadCurrentAccountComposite(local: local, secure: secure);
}
