import 'package:flutter_api_demo/models/api/entities/Genre.dart';
import 'package:flutter_api_demo/models/api/entities/Photo.dart';
import 'package:flutter_api_demo/models/api/entities/Budget.dart';

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
