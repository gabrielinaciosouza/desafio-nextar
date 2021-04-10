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
    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 204:
        throw HttpError.noContent;
      case 400:
        throw HttpError.badRequest;
      case 500:
        throw HttpError.serverError;
      default:
        throw HttpError.invalidData;
    }
  }
}
