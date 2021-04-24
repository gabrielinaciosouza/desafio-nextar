import '../../../domain/usecases/usecases.dart';

import '../../composites/composites.dart';

import '../factories.dart';

DeleteFromCache makeLogoffComposite() {
  final secure = makeSecureLogoff();
  final local = makeLogoff();
  return LogoffComposite(local: local, secure: secure);
}
