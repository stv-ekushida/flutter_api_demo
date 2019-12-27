import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_api_demo/models/api/GourmetRequestParameter.dart';
import 'package:flutter_api_demo/models/api/GourmetResponse.dart';

class APIClient {
  final endpoint = 'webservice.recruit.co.jp';
  final int timeoutTime = 10;

  /// グルメサーチAPIコール
  Future<GourmetResponse> getGourmet() async {
    final requestParameter = GourmetRequestParameter(keyword: '五反田');

    final response = await http
        .get(Uri.http(
            endpoint, requestParameter.path, requestParameter.toJson()))
        .timeout(Duration(seconds: timeoutTime));

    print('REQUEST : https://${endpoint}${requestParameter.path}\n PARAMS : ${requestParameter.toJson()}');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print('RESPONSE : ${response.statusCode} \n${response.body}');
      GourmetResponse results = GourmetResponse.fromJSON(body);
      return results;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
