
import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class WaterPlantDatabaseHelper {
  static const _databaseName = "WaterPlantDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'water_plant_data';

  WaterPlantDatabaseHelper._privateConstructor();
  static final WaterPlantDatabaseHelper instance = WaterPlantDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        unitId TEXT NOT NULL,
        areaId TEXT NOT NULL,
        routeId TEXT NOT NULL,
        latt TEXT NOT NULL,
        long TEXT NOT NULL,
        powerSupply TEXT,
        productFlow TEXT,
        rejectFlow TEXT,
        sandFilterPressure TEXT,
        carbonFilterPressure TEXT,
        systemPressure TEXT,
        tds TEXT,
        coinMeterReading TEXT,
        kebMeterReading TEXT,
        pictures TEXT
      )
    ''');
  }

  Future<int> insertWaterPlantData(WaterPlantDataModel data) async {
    Database db = await database;
    return await db.insert(table, data.toJson()..['pictures'] = picturesToJson(data.pictures));
  }

  Future<List<WaterPlantDataModel>> getStoredData() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);

    return maps.map((map) {
      return WaterPlantDataModel.fromJson(map..['pictures'] = picturesFromJson(map['pictures']));
    }).toList();
  }

  Future<void> deleteWaterPlantData(int id) async {
    Database db = await database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

/// Helper functions for pictures (List<Picture> serialization)
String picturesToJson(List<Picture> pictures) {
  return pictures.map((pic) => pic.toJson()).toList().toString();
}

List<Picture> picturesFromJson(String picturesJson) {
  return (picturesJson as List).map((item) => Picture.fromJson(item)).toList();
}
