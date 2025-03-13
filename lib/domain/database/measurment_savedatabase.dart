
import 'dart:convert';

import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



import 'dart:developer';



class WaterPlantDatabaseHelper {
  static const _databaseName = "WaterPlantDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'water_plant_data';

  WaterPlantDatabaseHelper._privateConstructor();
  static final WaterPlantDatabaseHelper instance =
      WaterPlantDatabaseHelper._privateConstructor();
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
        areaName TEXT NOT NULL,
        routeId TEXT NOT NULL,
        routeName TEXT NOT NULL,
        latt TEXT NOT NULL,
        long TEXT NOT NULL,
        powerSupply TEXT,
        productFlow TEXT,
        rejectFlow TEXT,
        sandFilterPressure TEXT,
        carbonFilterPressure TEXT,
        systemPressure TEXT,
        tds TEXT,
        waterLtrsReading TEXT,
        coinMeterReading TEXT,
        kebMeterReading TEXT,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
        pictures TEXT
      )
    ''');
    log("Database table created.");
  }

  Future<int> insertWaterPlantData(WaterPlantDataModel data) async {
    Database db = await database;
    
    // Convert the model to JSON
    Map<String, dynamic> row = data.toJson();
    
    // Pictures need special handling for SQLite storage
    List<Map<String, dynamic>> picturesJson = [];
    
    // Process each Picture object in the list
    for (var picture in data.pictures) {
      // Convert each Picture object to a simple map
      picturesJson.add({
        'imageName': picture.imageName,
        'pictureType': picture.pictureType,
        'image': picture.image
      });
    }
    
    // Replace the pictures list with the JSON string representation
    row['pictures'] = jsonEncode(picturesJson);
    
    // Remove any id field since SQLite will assign one
    if (row.containsKey('id')) {
      row.remove('id');
    }
    
    int id = await db.insert(table, row);
    log("Inserted Data (ID: $id)");
    return id;
  }

  Future<List<WaterPlantDataModel>> getStoredData() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(table);
    log("Total Records in DB: ${maps.length}");
    
    List<WaterPlantDataModel> result = [];
    
    for (var map in maps) {
      try {
        // Convert the stored pictures JSON string back to a list of Picture objects
        List<Picture> pictures = [];
        if (map['pictures'] != null) {
          List<dynamic> picturesData = jsonDecode(map['pictures']);
          for (var picData in picturesData) {
            pictures.add(Picture(
              imageName: picData['imageName'],
              pictureType: picData['pictureType'],
              image: picData['image']
            ));
          }
        }
        
        // Create a new model instance with the database ID
        result.add(WaterPlantDataModel(
          id: map['id'],
          unitId: map['unitId'],
          areaId: map['areaId'],
          areaName: map['areaName'],
          routeId: map['routeId'],
          routeName: map['routeName'],
          latt: map['latt'],
          long: map['long'],
          powerSupply: map['powerSupply'],
          productFlow: map['productFlow'],
          rejectFlow: map['rejectFlow'],
          sandFilterPressure: map['sandFilterPressure'],
          carbonFilterPressure: map['carbonFilterPressure'],
          systemPressure: map['systemPressure'],
          tds: map['tds'],
          coinMeterReading: map['coinMeterReading'],
          kebMeterReading: map['kebMeterReading'],
          createdAt: map['createdAt'],
          pictures: pictures
        ));
      } catch (e) {
        log("Error creating model from database row: $e");
      }
    }
    
    return result;
  }

  Future<void> deleteWaterPlantData(int id) async {
    Database db = await database;
    int rowsAffected = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    log("Deleted Record (ID: $id), Rows Affected: $rowsAffected");
  }
  
  Future<void> deleteAllWaterPlantData() async {
    Database db = await database;
    int rowsAffected = await db.delete(table);
    log("Deleted All Records, Rows Affected: $rowsAffected");
  }
}

// ///////////////
class NetworkChecker {
  static Future<bool> hasNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final results =  connectivityResult;
    return results.contains(ConnectivityResult.mobile) || 
           results.contains(ConnectivityResult.wifi);
  }
}