
class Budget {
  final String average;

  Budget({this.average});

  factory Budget.fromJSON(Map<String, dynamic> json) {
    return Budget(average: json['average']);
  }
}