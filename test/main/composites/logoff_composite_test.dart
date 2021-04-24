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
    try {
      await secure.delete(code);
    } catch (error) {
      await local.delete(code);
    }
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

  void throwSecureError() {
    when(secure.delete(key)).thenThrow(Exception());
  }

  void throwLocalError() {
    when(local.delete(key)).thenThrow(Exception());
  }

  test('Should call secure delete', () async {
    await sut.delete(key);

    verify(secure.delete(key));
  });

  test('Should call local delete if secure fails', () async {
    throwSecureError();
    await sut.delete(key);

    verify(local.delete(key));
  });

  test('Should throw if local throws', () async {
    throwSecureError();
    throwLocalError();
    final future = sut.delete(key);

    expect(future, throwsA(TypeMatcher<Exception>()));
  });
}
