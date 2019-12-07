import 'package:flutter_api_demo/models/api/utils/RequestParameter.dart';

class GourmetRequestParameter extends Object with RequestParameter  {
  final String path = '/hotpepper/gourmet/v1';
  final String keyword;

  GourmetRequestParameter({this.keyword});

  Map<String, String> toJson() => {
    'key': key,
    'format': format,
    'keyword' : keyword,
    'count' : count.toString()
  };
}