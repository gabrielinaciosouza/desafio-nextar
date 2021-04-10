import 'dart:convert';

import 'package:desafio_nextar/data/http/http.dart';
import 'package:http/http.dart';

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
    if (response.body.isEmpty && response.statusCode == 204) {
      throw HttpError.noContent;
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw HttpError.invalidData;
  }
}
