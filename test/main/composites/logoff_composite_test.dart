import 'package:desafio_nextar/data/usecases/usecases.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalSecureLogoffSpy extends Mock implements LocalSecureLogoff {
  @override
  Future<void> delete(String key) =>
      this.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class LocalLogoffSpy extends Mock implements LocalLogoff {
  @override
  Future<void> delete(String key) =>
      this.noSuchMethod(Invocation.method(#delete, [key]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class LogoffComposite implements DeleteFromCache {
  DeleteFromCache secure;
  DeleteFromCache local;

  LogoffComposite({required this.local, required this.secure});

  @override
  Future<void> delete(String code) async {
    await secure.delete(code);
  }
}

void main() {
  late LogoffComposite sut;
  late LocalSecureLogoff secure;
  late LocalLogoff local;
  late String key;

  setUp(() {
    secure = LocalSecureLogoffSpy();
    local = LocalLogoffSpy();
    sut = LogoffComposite(secure: secure, local: local);
    key = 'token';
  });

  test('Should call secure delete', () async {
    await sut.delete(key);

    verify(secure.delete(key));
  });
}
