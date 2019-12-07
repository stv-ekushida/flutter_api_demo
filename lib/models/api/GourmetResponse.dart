import 'package:flutter_api_demo/models/api/entities/Shop.dart';

class GourmetResponse {

  final Results results;

  GourmetResponse({this.results});

  factory GourmetResponse.fromJSON(Map<String, dynamic> parsedJson) {

    return GourmetResponse(
        results: Results.fromJSON(parsedJson['results']));
  }
}

class Results {

  final String api_version;
  final String results_returned;
  final List<Shop> shop;

  Results({this.api_version, this.results_returned, this.shop});

  factory Results.fromJSON(Map<String, dynamic> json) {

    return Results(
        api_version: json['api_version'],
        results_returned: json['results_returned'],
        shop: parseShops(json)
    );
  }

  static List<Shop> parseShops(json) {
    var list = json['shop'] as List;
    List<Shop> shops = list.map((data) => Shop.fromJSON(data)).toList();
    return shops;
  }
}