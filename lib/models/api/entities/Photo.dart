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
