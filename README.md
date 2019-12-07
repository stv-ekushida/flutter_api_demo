# flutter_api_demo
APIクライアントのデモ

## API関連

### リクエストパラメタの書式

```dart
abstract class RequestParameter {
  final String path = '/';
  final String key = 'XXXXXXXXXXX';
  final String format = 'json';
  final int count = 50;
}
```


### 個別のリクエストパラメタ

```dart
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
```

### APIクライアント

```dart
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

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      GourmetResponse results = GourmetResponse.fromJSON(body);
      return results;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
```

### 使い方

```dart
APIClient().getGourmet().then((response) {
      _shops.addAll(response.results.shop);
    }).catchError((err) {
      //エラー時の処理
      print(err.toString());
    }).whenComplete(() => isLoadingComplated = true);
```


## レスポンスデータ

### レスポンスデータ（最上位階層）

```dart
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
```

### レスポンスデータ（配列がネストしている場合）

```dart
class Shop {
  final String name;
  final String open;
  final String access;
  final String address;
  final Genre genre;
  final Photo photo;
  final Budget budget;

  Shop(
      {this.name,
      this.open,
      this.access,
      this.address,
      this.genre,
      this.photo,
      this.budget});

  factory Shop.fromJSON(Map<String, dynamic> json) {
    return Shop(
      name: json['name'],
      open: json['open'],
      access: json['access'],
      address: json['address'],
      genre: Genre.fromJSON(json['genre']),
      photo: Photo.fromJSON(json['photo']),
      budget: Budget.fromJSON(json['budget']),
    );
  }
}
```

### レスポンスデータ（オブジェクト型がネストしている場合）

```dart
class Photo {
  final Mobile mobile;

  Photo({this.mobile});

  factory Photo.fromJSON(Map<String, dynamic> json) {
    return Photo(mobile: Mobile.fromJSON(json['mobile']));
  }
}

class Mobile {
  final String large;

  Mobile({this.large});

  factory Mobile.fromJSON(Map<String, dynamic> json) {
    return Mobile(large: json['l']);
  }
}
```
