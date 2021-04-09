import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:loja_virtual/data/usecases/usecases.dart';
import 'package:loja_virtual/data/cache/cache.dart';
import 'package:loja_virtual/domain/helpers/helpers.dart';

class LogoffCacheStorageSpy extends Mock implements DeleteCacheStorage {
  @override
  Future<void> delete({required String key}) {
    return this.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value());
  }
}

void main() {
  late LogoffCacheStorageSpy logoffCacheStorage;
  late LocalLogoff sut;
  late String key;

  PostExpectation mockLogoffCacheStorageCall() =>
      when(logoffCacheStorage.delete(key: key));

  mockError() {
    mockLogoffCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    key = 'any_key';
    logoffCacheStorage = LogoffCacheStorageSpy();
    sut = LocalLogoff(deleteCacheStorage: logoffCacheStorage);
  });
  test('Should call LogoffCacheStorage with correct values', () async {
    await sut.delete(key);

    verify(logoffCacheStorage.delete(key: key));
  });

  test('Should throw unexpected error if LogoffCacheStorage thorws', () async {
    mockError();

    final future = sut.delete(key);

    expect(future, throwsA(DomainError.unexpected));
  });
}
