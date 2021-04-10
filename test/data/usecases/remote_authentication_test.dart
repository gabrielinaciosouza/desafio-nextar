import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/http/http.dart';
import 'package:desafio_nextar/data/usecases/usecases.dart';

import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {
  @override
  Future<void> request(
          {required String url, required String method, Map? body}) =>
      this.noSuchMethod(Invocation.method(#request, [url]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late HttpClientSpy httpClient;
  late String url;
  late RemoteAuthentication sut;
  late Map body;
  late AuthenticationParams params;

  setUp(() {
    url = 'http://url.com/api';
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: 'mail@email.com', password: '123456');
    body = {'email': params.email, 'password': params.password};
  });

  void throwHttpError(HttpError error) {
    when(httpClient.request(url: url, method: 'post', body: body))
        .thenThrow(error);
  }

  test('Should call HttpClient with correct URL', () async {
    await sut.auth(params);

    verify(httpClient.request(url: url, method: 'post', body: body));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    throwHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
