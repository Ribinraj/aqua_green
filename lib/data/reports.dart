
class ReportModel {
  final String? measurementId;
  final String? latt;
  final String? long;
  final String? productFlow;
  final String? rejectFlow;
  final String? sandFilterPressure;
  final String? carbonFilterPressure;
  final String? systemPressure;
  final String? tds;
  final String? waterLtrsReading;
  final String? coinMeterReading;
  final String? kebMeterReading;
  final String? prevCoinMeterReading;
  final String? prevKebMeterReading;
  final String? coinCollection;
  final String? revenue;
  final String? distance;
  final String? userId;
  final String? status;
  final CreatedAt? createdAt;
  final String? modifiedAt;
  final String? areaName;
  final String? routeName;
  final String? unitName;
  final List<Picture>? pictures;

  ReportModel({
    this.measurementId,
    this.latt,
    this.long,
    this.productFlow,
    this.rejectFlow,
    this.sandFilterPressure,
    this.carbonFilterPressure,
    this.systemPressure,
    this.tds,
    this.waterLtrsReading,
    this.coinMeterReading,
    this.kebMeterReading,
    this.prevCoinMeterReading,
    this.prevKebMeterReading,
    this.coinCollection,
    this.revenue,
    this.distance,
    this.userId,
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.areaName,
    this.routeName,
    this.unitName,
    this.pictures,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      measurementId: json['measurementId'] as String?,
      latt: json['latt'] as String?,
      long: json['long'] as String?,
      productFlow: json['productFlow'] as String?,
      rejectFlow: json['rejectFlow'] as String?,
      sandFilterPressure: json['sandFilterPressure'] as String?,
      carbonFilterPressure: json['carbonFilterPressure'] as String?,
      systemPressure: json['systemPressure'] as String?,
      tds: json['tds'] as String?,
      waterLtrsReading: json['waterLtrsReading'] as String?,
      coinMeterReading: json['coinMeterReading'] as String?,
      kebMeterReading: json['kebMeterReading'] as String?,
      prevCoinMeterReading: json['prevCoinMeterReading'] as String?,
      prevKebMeterReading: json['prevKebMeterReading'] as String?,
      coinCollection: json['coinCollection'] as String?,
      revenue: json['revenue'] as String?,
      distance: json['distance'] as String?,
      userId: json['userId'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null ? CreatedAt.fromJson(json['created_at'] as Map<String, dynamic>) : null,
      modifiedAt: json['modified_at'] as String?,
      areaName: json['areaName'] as String?,
      routeName: json['routeName'] as String?,
      unitName: json['unitName'] as String?,
      pictures: (json['pictures'] as List<dynamic>?)?.map((e) => Picture.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'measurementId': measurementId,
      'latt': latt,
      'long': long,
      'productFlow': productFlow,
      'rejectFlow': rejectFlow,
      'sandFilterPressure': sandFilterPressure,
      'carbonFilterPressure': carbonFilterPressure,
      'systemPressure': systemPressure,
      'tds': tds,
      'waterLtrsReading': waterLtrsReading,
      'coinMeterReading': coinMeterReading,
      'kebMeterReading': kebMeterReading,
      'prevCoinMeterReading': prevCoinMeterReading,
      'prevKebMeterReading': prevKebMeterReading,
      'coinCollection': coinCollection,
      'revenue': revenue,
      'distance': distance,
      'userId': userId,
      'status': status,
      'created_at': createdAt?.toJson(),
      'modified_at': modifiedAt,
      'areaName': areaName,
      'routeName': routeName,
      'unitName': unitName,
      'pictures': pictures?.map((e) => e.toJson()).toList(),
    };
  }
}
class Picture {
  final String? pictureType;
  final String? imageName;
  final String? image;

  Picture({
    this.pictureType,
    this.imageName,
    this.image,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureType: json['pictureType'] as String?,
      imageName: json['imageName'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pictureType': pictureType,
      'imageName': imageName,
      'image': image,
    };
  }
}

class CreatedAt {
  final String? date;
  final int? timezoneType;
  final String? timezone;

  CreatedAt({
    this.date,
    this.timezone,
    this.timezoneType,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date'] as String?,
      timezoneType: json['timezone_type'] as int?,
      timezone: json['timezone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timezone_type': timezoneType,
      'timezone': timezone,
    };
  }
}
