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
  Future<void> request({required String url, required String method}) async {
    await client.post(Uri.parse(url));
  }
}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = 'http://fakeurl.com';

      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url)));
    });
  });
}
