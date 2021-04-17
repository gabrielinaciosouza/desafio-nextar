import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/http/http.dart';
import 'package:desafio_nextar/data/usecases/usecases.dart';

import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<Map> request(
          {required String url, required String method, Map? body}) =>
      this.noSuchMethod(Invocation.method(#request, [url]),
          returnValue: Future.value({}),
          returnValueForMissingStub: Future.value({}));
}

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;
  late Map body;
  late AuthenticationParams params;
  late String accessToken;

  PostExpectation mockHttpCall() =>
      when(httpClient.request(url: url, method: 'post', body: body));

  void throwHttpError(HttpError error) {
    mockHttpCall().thenThrow(error);
  }

  void mockClientSuccessResponse() {
    mockHttpCall().thenAnswer((_) async => {'accessToken': accessToken});
  }

  void mockClientInvalidResponse() {
    mockHttpCall().thenAnswer((_) async => {'invalid_key': 'invalid_value'});
  }

  setUp(() {
    url = 'http://url.com/api';
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: 'mail@email.com', password: '123456');
    body = {'email': params.email, 'password': params.password};
    accessToken = 'any_access_token';
    mockClientSuccessResponse();
  });

  test('Should call HttpClient with correct URL', () async {
    await sut.auth(params);

    verify(httpClient.request(url: url, method: 'post', body: body));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    throwHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    throwHttpError(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentials if HttpClient returns 401', () async {
    throwHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    throwHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an Account if HttpCLient returns 200', () async {
    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });

  test(
      'Should throw UnexpectedError if HttpCLient returns 200 with invalid data',
      () async {
    mockClientInvalidResponse();
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
