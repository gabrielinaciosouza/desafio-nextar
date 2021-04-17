import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('token');
      return AccountEntity(token: token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class FetchSecureCacheStorage {
  Future<String> fetchSecure(String key);
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {
  final String response;
  FetchSecureCacheStorageSpy({required this.response});
  @override
  Future<String> fetchSecure(String key) => this.noSuchMethod(
        Invocation.method(#fetchSecure, [key]),
        returnValue: Future.value(response),
        returnValueForMissingStub: Future.value(response),
      );
}

void main() {
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  PostExpectation fetchSecureStorageCall() =>
      when(fetchSecureCacheStorage.fetchSecure('token'));

  void mockResponse() {
    fetchSecureStorageCall().thenAnswer((_) async => token);
  }

  void throwError() {
    fetchSecureStorageCall().thenThrow(Exception());
  }

  setUp(() {
    token = 'any_token';
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy(response: token);
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    mockResponse();
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token: token));
  });

  test('Should throw unexpected error if fetch secure cache storage throws',
      () async {
    throwError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
