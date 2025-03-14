// class WaterPlantDataModel {
//   final String unitId;
//   final String areaId;
//   final String routeId;
//   final String latt;
//   final String long;
//   final String productFlow;
//   final String rejectFlow;
//   final String sandFilterPressure;
//   final String carbonFilterPressure;
//   final String systemPressure;
//   final String tds;
//   final String waterLtrsReading;
//   final String coinMeterReading;
//   final String kebMeterReading;
//   final List<PictureData> pictures;

//   WaterPlantDataModel({
//     required this.unitId,
//     required this.areaId,
//     required this.routeId,
//     required this.latt,
//     required this.long,
//     required this.productFlow,
//     required this.rejectFlow,
//     required this.sandFilterPressure,
//     required this.carbonFilterPressure,
//     required this.systemPressure,
//     required this.tds,
//     required this.waterLtrsReading,
//     required this.coinMeterReading,
//     required this.kebMeterReading,
//     this.pictures = const [],
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'unitId': unitId,
//       'areaId': areaId,
//       'routeId': routeId,
//       'latt': latt,
//       'long': long,
//       'productFlow': productFlow,
//       'rejectFlow': rejectFlow,
//       'sandFilterPressure': sandFilterPressure,
//       'carbonFilterPressure': carbonFilterPressure,
//       'systemPressure': systemPressure,
//       'tds': tds,
//       'waterLtrsReading': waterLtrsReading,
//       'coinMeterReading': coinMeterReading,
//       'kebMeterReading': kebMeterReading,
//       'pictures': pictures.map((picture) => picture.toJson()).toList(),
//     };
//   }
// factory WaterPlantDataModel.fromJson(Map<String, dynamic> json) {
//   return WaterPlantDataModel(
//     unitId: json['unitId'] ?? '',
//     areaId: json['areaId'] ?? '',
//     routeId: json['routeId'] ?? '',
//     latt: json['latt'] ?? '',
//     long: json['long'] ?? '',
//     productFlow: json['productFlow']??'',
//     rejectFlow: json['rejectFlow']??'',
//     sandFilterPressure: json['sandFilterPressure']??'',
//     carbonFilterPressure: json['carbonFilterPressure']??'',
//     systemPressure: json['systemPressure']??'',
//     tds: json['tds']??'',
//     waterLtrsReading: json['waterLtrsReading']??'',
//     coinMeterReading: json['coinMeterReading']??'',
//     kebMeterReading: json['kebMeterReading']??'',
//     pictures: (json['pictures'] as List<dynamic>?)
//             ?.map((picture) => PictureData.fromJson(picture))
//             .toList() ??
//         [],
//   );
// }

// }

// class PictureData {
//   final String? imageName;
//   final String pictureType;
//   final String? image;

//   PictureData({
//     this.imageName,
//     required this.pictureType,
//     this.image,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'imageName': imageName,
//       'pictureType': pictureType,
//       'image': image,
//     };
//   }

//   factory PictureData.fromJson(Map<String, dynamic> json) {
//     return PictureData(
//       imageName: json['imageName'],
//       pictureType: json['pictureType'],
//       image: json['image'],
//     );
//   }
// }
//////////////
class WaterPlantDataModel {
  int? id;
  String unitId;
  String areaId;
  String areaName;
  String routeId;
  String routeName;
  String latt;
  String long;
  String? powerSupply;
  String? productFlow;
  String? rejectFlow;
  String? sandFilterPressure;
  String? carbonFilterPressure;
  String? systemPressure;
  String? tds;
  //String? waterLtrsReading;
  String? coinMeterReading;
  String? kebMeterReading;
  String createdAt;
  List<Picture> pictures;

  WaterPlantDataModel({
    this.id,
    required this.unitId,
    required this.areaId,
    required this.areaName,

    required this.routeId,
    required this.routeName,
    required this.latt,
    required this.long,
    this.powerSupply,
    this.productFlow,
    this.rejectFlow,
    this.sandFilterPressure,
    this.carbonFilterPressure,
    this.systemPressure,
    this.tds,
    //this.waterLtrsReading,
    this.coinMeterReading,
    this.kebMeterReading,
   
    required this.pictures,
    String? createdAt,
  }) : createdAt = createdAt??DateTime.now().toString();

  factory WaterPlantDataModel.fromJson(Map<String, dynamic> json) =>
      WaterPlantDataModel(
        id: json["id"] ?? '',
        unitId: json["unitId"] ?? '',
        areaId: json["areaId"] ?? '',
        areaName: json["areaName"] ?? '',
        routeId: json["routeId"] ?? '',
        routeName: json["routeName"] ?? '',
        latt: json["latt"] ?? '',
        long: json["long"] ?? '',
        powerSupply: json["powerSupply"] ?? '',
        productFlow: json["productFlow"],
        rejectFlow: json["rejectFlow"],
        sandFilterPressure: json["sandFilterPressure"],
        carbonFilterPressure: json["carbonFilterPressure"],
        systemPressure: json["systemPressure"],
        tds: json["tds"],
        // waterLtrsReading: json["waterLtrsReading"],
        coinMeterReading: json["coinMeterReading"],
        kebMeterReading: json["kebMeterReading"],
        createdAt: json["createdAt"],
        pictures: List<Picture>.from(
            json["pictures"].map((x) => Picture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitId": unitId,
        "areaId": areaId,
        "areaName": areaName,
        "routeId": routeId,
        "routeName": routeName,
        "latt": latt,
        "long": long,
        "powerSupply": powerSupply,
        "productFlow": productFlow,
        "rejectFlow": rejectFlow,
        "sandFilterPressure": sandFilterPressure,
        "carbonFilterPressure": carbonFilterPressure,
        "systemPressure": systemPressure,
        "tds": tds,
        // "waterLtrsReading": waterLtrsReading,
        "coinMeterReading": coinMeterReading,
        "kebMeterReading": kebMeterReading,
        "createdAt": createdAt,
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
      };
}

class Picture {
  String imageName;
  String pictureType;
  String image;

  Picture({
    required this.imageName,
    required this.pictureType,
    required this.image,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        imageName: json["imageName"],
        pictureType: json["pictureType"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "imageName": imageName,
        "pictureType": pictureType,
        "image": image,
      };
}
