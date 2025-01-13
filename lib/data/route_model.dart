class RouteModel {
  final String routeId;
  final String routeName;
  final DateTime createdAt;
  final DateTime modifiedAt;

  RouteModel({
    required this.routeId,
    required this.routeName,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeId: json['routeId'],
      routeName: json['routeName'],
      createdAt: DateTime.parse(json['created_at']['date']),
      modifiedAt: DateTime.parse(json['modified_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routeId': routeId,
      'routeName': routeName,
      'created_at': {
        'date': createdAt.toIso8601String(),
        'timezone_type': 3,
        'timezone': 'Asia/Kolkata',
      },
      'modified_at': modifiedAt.toIso8601String(),
    };
  }
}
