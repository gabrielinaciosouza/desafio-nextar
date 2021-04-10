import 'dart:convert';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/data/http/http.dart';
import 'package:desafio_nextar/infra/http/http.dart';

class ClientSpy extends Mock implements Client {
  @override
  Future<Response> post(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      this.noSuchMethod(Invocation.method(#post, []),
          returnValue: Future.value(Response('', 200)),
          returnValueForMissingStub: Future.value(Response('', 200)));
}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;
  late Map<String, String> headers;

  PostExpectation httpClientCall() =>
      when(client.post(Uri.parse(url), headers: headers));

  void mockResponse(Response response) {
    httpClientCall().thenAnswer((_) async => response);
  }

  void throwHttpError(HttpError error) {
    httpClientCall().thenThrow(error);
  }

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = 'http://fakeurl.com';
    headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    mockResponse(Response('{"any_key":"any_value"}', 200));
  });
  group('post', () {
    test('Should call post with correct values', () async {
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: headers, body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url), headers: headers));
    });

    test('Should return data if post returns 200', () async {
      mockResponse(Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should throw HttpError.noContent if post returns 204', () async {
      throwHttpError(HttpError.noContent);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.noContent));
    });
  });
}
