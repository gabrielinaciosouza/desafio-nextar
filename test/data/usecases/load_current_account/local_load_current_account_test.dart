import 'package:loja_virtual/data/cache/cache.dart';
import 'package:loja_virtual/data/usecases/load_current_account/load_current_account.dart';
import 'package:loja_virtual/domain/entities/entities.dart';
import 'package:loja_virtual/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {
  final String response;
  FetchCacheStorageSpy({required this.response});
  @override
  Future<String> fetch(String key) => this.noSuchMethod(
        Invocation.method(#fetch, [key]),
        returnValue: Future.value(response),
        returnValueForMissingStub: Future.value(response),
      );
}

void main() {
  late FetchCacheStorageSpy fetchCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  PostExpectation fetchStorageCall() => when(fetchCacheStorage.fetch('token'));

  void mockResponse(String response) {
    fetchStorageCall().thenAnswer((_) async => response);
  }

  void throwError() {
    fetchStorageCall().thenThrow(Exception());
  }

  setUp(() {
    token = 'any_token';
    fetchCacheStorage = FetchCacheStorageSpy(response: token);
    sut = LocalLoadCurrentAccount(fetchCacheStorage: fetchCacheStorage);
    mockResponse(token);
  });

  test('Should call FetchCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('token'));
  });

  test('Should throw unexpected error if token is invalid', () async {
    mockResponse('');

    final error = sut.load();

    expect(error, throwsA(DomainError.unexpected));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('Should throw unexpected error if fetch cache storage throws', () async {
    throwError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
