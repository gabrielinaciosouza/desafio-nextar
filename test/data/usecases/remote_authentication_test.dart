import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void> request(
      {required String url, required String method, Map? body});
}

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

  setUp(() {
    url = 'http://url.com/api';
    httpClient = HttpClientSpy();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct URL', () async {
    final params =
        AuthenticationParams(email: 'mail@email.com', password: '123456');
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });
}
