import 'dart:convert';

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

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);
  Future<void> request(
      {required String url, required String method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
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
  });
}
