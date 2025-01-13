class UnitModel {
  final String unitId;
  final String unitName;
  final String? googleMap;
  final double? latitude;
  final double? longitude;
  final String coinReading;
  final String kebReading;
  final String areaId;
  final String routeId;
  final DateTime createdAt;
  final String modifiedAt;

  UnitModel({
    required this.unitId,
    required this.unitName,
    this.googleMap,
    this.latitude,
    this.longitude,
    required this.coinReading,
    required this.kebReading,
    required this.areaId,
    required this.routeId,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      unitId: json['unitId'] ?? '',
      unitName: json['unitName'] ?? '',
      googleMap: json['googleMap'],
      latitude: json['latt'] != null ? double.tryParse(json['latt'].toString()) : null,
      longitude: json['long'] != null ? double.tryParse(json['long'].toString()) : null,
      coinReading: json['coinReading'] ?? '0',
      kebReading: json['kebReading'] ?? '0',
      areaId: json['areaId'] ?? '',
      routeId: json['routeId'] ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']['date'])
          : DateTime.now(),
      modifiedAt: json['modified_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitId': unitId,
      'unitName': unitName,
      'googleMap': googleMap,
      'latt': latitude,
      'long': longitude,
      'coinReading': coinReading,
      'kebReading': kebReading,
      'areaId': areaId,
      'routeId': routeId,
      'created_at': {
        'date': createdAt.toIso8601String(),
        'timezone_type': 3,
        'timezone': 'Asia/Kolkata'
      },
      'modified_at': modifiedAt,
    };
  }
}
