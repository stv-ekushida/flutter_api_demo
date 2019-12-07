
class Genre {
  final String name;

  Genre({this.name});

  factory Genre.fromJSON(Map<String, dynamic> json) {
    return Genre(name: json['name']);
  }
}