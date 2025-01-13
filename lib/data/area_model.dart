class AreaModel {
  final String areaId;
  final String areaName;
  final String routeId;
  final DateTime createdAt;
  final String modifiedAt;

  AreaModel({
    required this.areaId,
    required this.areaName,
    required this.routeId,
    required this.createdAt,
    required this.modifiedAt,
  });

  // Factory method to create an AreaModel object from JSON
  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      areaId: json['areaId'] as String,
      areaName: json['areaName'] as String,
      routeId: json['routeId'] as String,
      createdAt: DateTime.parse(json['created_at']['date'] as String),
      modifiedAt: json['modified_at'] as String,
    );
  }

  // Method to convert an AreaModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'areaId': areaId,
      'areaName': areaName,
      'routeId': routeId,
      'created_at': {'date': createdAt.toIso8601String()},
      'modified_at': modifiedAt,
    };
  }
}
