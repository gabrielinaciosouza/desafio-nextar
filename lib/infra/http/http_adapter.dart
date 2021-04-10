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
    var response = Response('', 500);
    try {
      if (method == 'post') {
        response = await client.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
      }
    } catch (error) {
      throw HttpError.serverError;
    }

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
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.invalidData;
    }
  }
}
