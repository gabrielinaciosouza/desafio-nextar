import 'dart:convert';

import 'package:desafio_nextar/data/http/http.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client {
  @override
  Future<Response> post(Uri url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      this.noSuchMethod(Invocation.method(#post, []),
          returnValue: Future.value(Response('', 200)),
          returnValueForMissingStub: Future.value(Response('', 200)));
}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);
  Future<Map> request(
      {required String url, required String method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final response = await client.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    return jsonDecode(response.body);
  }
}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;
  late Map<String, String> headers;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = 'http://fakeurl.com';
    headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
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
      when(client.post(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}
