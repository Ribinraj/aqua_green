// import 'package:aqua_green/data/route_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';


// class RouteDatabaseHelper {
//   static final RouteDatabaseHelper _instance = RouteDatabaseHelper._internal();
//   static Database? _database;

//   factory RouteDatabaseHelper() => _instance;

//   RouteDatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'routes_database.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute('''
//           CREATE TABLE routes(
//             routeId TEXT PRIMARY KEY,
//             routeName TEXT,
//             createdAt TEXT,
//             modifiedAt TEXT,
//             lastSyncTime INTEGER
//           )
//         ''');
//       },
//     );
//   }

//   Future<void> insertRoute(RouteModel route) async {
//     final Database db = await database;
//     await db.insert(
//       'routes',
//       {
//         'routeId': route.routeId,
//         'routeName': route.routeName,
//         'createdAt': route.createdAt.toIso8601String(),
//         'modifiedAt': route.modifiedAt.toIso8601String(),
//         'lastSyncTime': DateTime.now().millisecondsSinceEpoch,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> insertRoutes(List<RouteModel> routes) async {
//     final Database db = await database;
//     final Batch batch = db.batch();
    
//     for (var route in routes) {
//       batch.insert(
//         'routes',
//         {
//           'routeId': route.routeId,
//           'routeName': route.routeName,
//           'createdAt': route.createdAt.toIso8601String(),
//           'modifiedAt': route.modifiedAt.toIso8601String(),
//           'lastSyncTime': DateTime.now().millisecondsSinceEpoch,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
    
//     await batch.commit(noResult: true);
//   }

//   Future<List<RouteModel>> getAllRoutes() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('routes');
    
//     return List.generate(maps.length, (i) {
//       return RouteModel(
//         routeId: maps[i]['routeId'],
//         routeName: maps[i]['routeName'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: DateTime.parse(maps[i]['modifiedAt']),
//       );
//     });
//   }

//   Future<RouteModel?> getRouteById(String routeId) async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'routes',
//       where: 'routeId = ?',
//       whereArgs: [routeId],
//     );
    
//     if (maps.isNotEmpty) {
//       return RouteModel(
//         routeId: maps[0]['routeId'],
//         routeName: maps[0]['routeName'],
//         createdAt: DateTime.parse(maps[0]['createdAt']),
//         modifiedAt: DateTime.parse(maps[0]['modifiedAt']),
//       );
//     }
//     return null;
//   }

//   Future<void> updateRoute(RouteModel route) async {
//     final Database db = await database;
//     await db.update(
//       'routes',
//       {
//         'routeName': route.routeName,
//         'createdAt': route.createdAt.toIso8601String(),
//         'modifiedAt': route.modifiedAt.toIso8601String(),
//         'lastSyncTime': DateTime.now().millisecondsSinceEpoch,
//       },
//       where: 'routeId = ?',
//       whereArgs: [route.routeId],
//     );
//   }

//   Future<void> deleteRoute(String routeId) async {
//     final Database db = await database;
//     await db.delete(
//       'routes',
//       where: 'routeId = ?',
//       whereArgs: [routeId],
//     );
//   }

//   Future<void> clearAllRoutes() async {
//     final Database db = await database;
//     await db.delete('routes');
//   }
  
//   Future<DateTime?> getLastSyncTime() async {
//     final Database db = await database;
//     final List<Map<String, dynamic>> result = await db.rawQuery(
//       'SELECT MAX(lastSyncTime) as lastSync FROM routes'
//     );
    
//     if (result.first['lastSync'] != null) {
//       return DateTime.fromMillisecondsSinceEpoch(result.first['lastSync'] as int);
//     }
//     return null;
//   }
// }
/////////////////////////
import 'dart:async';
import 'dart:io';
import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('waterplant.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, filePath);
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     // Create Route table
//     await db.execute('''
//     CREATE TABLE routes (
//       routeId TEXT PRIMARY KEY,
//       routeName TEXT NOT NULL,
//       createdAt TEXT NOT NULL,
//       modifiedAt TEXT NOT NULL
//     )
//     ''');
//    debugPrint('Table routes created.');
//     // Create Area table
//     await db.execute('''
//     CREATE TABLE areas (
//       areaId TEXT PRIMARY KEY,
//       areaName TEXT NOT NULL,
//       routeId TEXT NOT NULL,
//       createdAt TEXT NOT NULL,
//       modifiedAt TEXT NOT NULL,
//       FOREIGN KEY (routeId) REFERENCES routes (routeId)
//     )
//     ''');
//    debugPrint('Table areas created.');
//     // Create Unit table
//     await db.execute('''
//     CREATE TABLE units (
//       unitId TEXT PRIMARY KEY,
//       unitName TEXT NOT NULL,
//       googleMap TEXT,
//       latitude REAL,
//       longitude REAL,
//       coinReading TEXT NOT NULL,
//       kebReading TEXT NOT NULL,
//       areaId TEXT NOT NULL,
//       routeId TEXT NOT NULL,
//       createdAt TEXT NOT NULL,
//       modifiedAt TEXT NOT NULL,
//       FOREIGN KEY (routeId) REFERENCES routes (routeId),
//       FOREIGN KEY (areaId) REFERENCES areas (areaId)
//     )
//     ''');
//        debugPrint('Table units created.');
//   }

//   // ROUTE OPERATIONS
//   Future<int> insertRoute(RouteModel route) async {
//     final db = await database;
//     return await db.insert(
//       'routes',
//       {
//         'routeId': route.routeId,
//         'routeName': route.routeName,
//         'createdAt': route.createdAt.toIso8601String(),
//         'modifiedAt': route.modifiedAt.toIso8601String(),
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
    
//   }

//   Future<List<RouteModel>> getRoutes() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('routes');
//     return List.generate(maps.length, (i) {
//       return RouteModel(
//         routeId: maps[i]['routeId'],
//         routeName: maps[i]['routeName'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: DateTime.parse(maps[i]['modifiedAt']),
//       );
//     });
//   }

//   Future<void> insertRoutes(List<RouteModel> routes) async {
//     final db = await database;
//     Batch batch = db.batch();
//     for (var route in routes) {
//       batch.insert(
//         'routes',
//         {
//           'routeId': route.routeId,
//           'routeName': route.routeName,
//           'createdAt': route.createdAt.toIso8601String(),
//           'modifiedAt': route.modifiedAt.toIso8601String(),
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//           debugPrint('Inserted Route: ${route.routeId}');
//     }
//     await batch.commit(noResult: true);
//   }

//   // AREA OPERATIONS
//   Future<int> insertArea(AreaModel area) async {
//     final db = await database;
//     return await db.insert(
//       'areas',
//       {
//         'areaId': area.areaId,
//         'areaName': area.areaName,
//         'routeId': area.routeId,
//         'createdAt': area.createdAt.toIso8601String(),
//         'modifiedAt': area.modifiedAt,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );

    
//   }

//   Future<List<AreaModel>> getAreas() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('areas');
//     return List.generate(maps.length, (i) {
//       return AreaModel(
//         areaId: maps[i]['areaId'],
//         areaName: maps[i]['areaName'],
//         routeId: maps[i]['routeId'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: maps[i]['modifiedAt'],
//       );
//     });
//   }

//   Future<List<AreaModel>> getAreasByRouteId(String routeId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'areas',
//       where: 'routeId = ?',
//       whereArgs: [routeId],
//     );
//     return List.generate(maps.length, (i) {
//       return AreaModel(
//         areaId: maps[i]['areaId'],
//         areaName: maps[i]['areaName'],
//         routeId: maps[i]['routeId'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: maps[i]['modifiedAt'],
//       );
//     });
//   }

//   Future<void> insertAreas(List<AreaModel> areas) async {
//     final db = await database;
//     Batch batch = db.batch();
//     for (var area in areas) {
//       batch.insert(
//         'areas',
//         {
//           'areaId': area.areaId,
//           'areaName': area.areaName,
//           'routeId': area.routeId,
//           'createdAt': area.createdAt.toIso8601String(),
//           'modifiedAt': area.modifiedAt,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//     await batch.commit(noResult: true);
//   }

//   // UNIT OPERATIONS
//   Future<int> insertUnit(UnitModel unit) async {
//     final db = await database;
//     return await db.insert(
//       'units',
//       {
//         'unitId': unit.unitId,
//         'unitName': unit.unitName,
//         'googleMap': unit.googleMap,
//         'latitude': unit.latitude,
//         'longitude': unit.longitude,
//         'coinReading': unit.coinReading,
//         'kebReading': unit.kebReading,
//         'areaId': unit.areaId,
//         'routeId': unit.routeId,
//         'createdAt': unit.createdAt.toIso8601String(),
//         'modifiedAt': unit.modifiedAt,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<UnitModel>> getUnits() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('units');
//     return List.generate(maps.length, (i) {
//       return UnitModel(
//         unitId: maps[i]['unitId'],
//         unitName: maps[i]['unitName'],
//         googleMap: maps[i]['googleMap'],
//         latitude: maps[i]['latitude'],
//         longitude: maps[i]['longitude'],
//         coinReading: maps[i]['coinReading'],
//         kebReading: maps[i]['kebReading'],
//         areaId: maps[i]['areaId'],
//         routeId: maps[i]['routeId'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: maps[i]['modifiedAt'],
//       );
//     });
//   }

//   Future<List<UnitModel>> getUnitsByRouteAndArea(String routeId, String areaId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'units',
//       where: 'routeId = ? AND areaId = ?',
//       whereArgs: [routeId, areaId],
//     );
//     return List.generate(maps.length, (i) {
//       return UnitModel(
//         unitId: maps[i]['unitId'],
//         unitName: maps[i]['unitName'],
//         googleMap: maps[i]['googleMap'],
//         latitude: maps[i]['latitude'],
//         longitude: maps[i]['longitude'],
//         coinReading: maps[i]['coinReading'],
//         kebReading: maps[i]['kebReading'],
//         areaId: maps[i]['areaId'],
//         routeId: maps[i]['routeId'],
//         createdAt: DateTime.parse(maps[i]['createdAt']),
//         modifiedAt: maps[i]['modifiedAt'],
//       );
//     });
//   }

//   Future<void> insertUnits(List<UnitModel> units) async {
//     final db = await database;
//     Batch batch = db.batch();
//     for (var unit in units) {
//       batch.insert(
//         'units',
//         {
//           'unitId': unit.unitId,
//           'unitName': unit.unitName,
//           'googleMap': unit.googleMap,
//           'latitude': unit.latitude,
//           'longitude': unit.longitude,
//           'coinReading': unit.coinReading,
//           'kebReading': unit.kebReading,
//           'areaId': unit.areaId,
//           'routeId': unit.routeId,
//           'createdAt': unit.createdAt.toIso8601String(),
//           'modifiedAt': unit.modifiedAt,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//     await batch.commit(noResult: true);
//   }

//   // ADDITIONAL UTILITY FUNCTIONS
//   Future<void> clearAllTables() async {
//     final db = await database;
//     await db.delete('units');
//     await db.delete('areas');
//     await db.delete('routes');
//   }

//   Future<void> close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
import 'dart:developer' as developer;


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('waterplant.db');
    developer.log('Database initialized successfully', name: 'DatabaseHelper');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);
    developer.log('Database path: $path', name: 'DatabaseHelper');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    developer.log('Creating database tables...', name: 'DatabaseHelper');
    
    // Create Route table
    await db.execute('''
    CREATE TABLE routes (
      routeId TEXT PRIMARY KEY,
      routeName TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      modifiedAt TEXT NOT NULL
    )
    ''');
    developer.log('Routes table created', name: 'DatabaseHelper');

    // Create Area table
    await db.execute('''
    CREATE TABLE areas (
      areaId TEXT PRIMARY KEY,
      areaName TEXT NOT NULL,
      routeId TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      modifiedAt TEXT NOT NULL,
      FOREIGN KEY (routeId) REFERENCES routes (routeId)
    )
    ''');
    developer.log('Areas table created', name: 'DatabaseHelper');

    // Create Unit table
    await db.execute('''
    CREATE TABLE units (
      unitId TEXT PRIMARY KEY,
      unitName TEXT NOT NULL,
      googleMap TEXT,
      latitude REAL,
      longitude REAL,
      coinReading TEXT NOT NULL,
      kebReading TEXT NOT NULL,
      areaId TEXT NOT NULL,
      routeId TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      modifiedAt TEXT NOT NULL,
      FOREIGN KEY (routeId) REFERENCES routes (routeId),
      FOREIGN KEY (areaId) REFERENCES areas (areaId)
    )
    ''');
    developer.log('Units table created', name: 'DatabaseHelper');
  }

  // ROUTE OPERATIONS
  Future<int> insertRoute(RouteModel route) async {
    final db = await database;
    developer.log('Inserting route: ${route.routeName}', name: 'DatabaseHelper');
    int result = await db.insert(
      'routes',
      {
        'routeId': route.routeId,
        'routeName': route.routeName,
        'createdAt': route.createdAt.toIso8601String(),
        'modifiedAt': route.modifiedAt.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Route inserted successfully: ${route.routeId}', name: 'DatabaseHelper');
    return result;
  }

  Future<List<RouteModel>> getRoutes() async {
    final db = await database;
    developer.log('Fetching all routes', name: 'DatabaseHelper');
    final List<Map<String, dynamic>> maps = await db.query('routes');
    developer.log('Fetched ${maps.length} routes', name: 'DatabaseHelper');
    return List.generate(maps.length, (i) {
      return RouteModel(
        routeId: maps[i]['routeId'],
        routeName: maps[i]['routeName'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        modifiedAt: DateTime.parse(maps[i]['modifiedAt']),
      );
    });
  }

  Future<void> insertRoutes(List<RouteModel> routes) async {
    final db = await database;
    developer.log('Batch inserting ${routes.length} routes', name: 'DatabaseHelper');
    Batch batch = db.batch();
    for (var route in routes) {
      batch.insert(
        'routes',
        {
          'routeId': route.routeId,
          'routeName': route.routeName,
          'createdAt': route.createdAt.toIso8601String(),
          'modifiedAt': route.modifiedAt.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    developer.log('${routes.length} routes inserted successfully', name: 'DatabaseHelper');
  }

  // AREA OPERATIONS
  Future<int> insertArea(AreaModel area) async {
    final db = await database;
    developer.log('Inserting area: ${area.areaName}', name: 'DatabaseHelper');
    int result = await db.insert(
      'areas',
      {
        'areaId': area.areaId,
        'areaName': area.areaName,
        'routeId': area.routeId,
        'createdAt': area.createdAt.toIso8601String(),
        'modifiedAt': area.modifiedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Area inserted successfully: ${area.areaId}', name: 'DatabaseHelper');
    return result;
  }

  Future<List<AreaModel>> getAreas() async {
    final db = await database;
    developer.log('Fetching all areas', name: 'DatabaseHelper');
    final List<Map<String, dynamic>> maps = await db.query('areas');
    developer.log('Fetched ${maps.length} areas', name: 'DatabaseHelper');
    return List.generate(maps.length, (i) {
      return AreaModel(
        areaId: maps[i]['areaId'],
        areaName: maps[i]['areaName'],
        routeId: maps[i]['routeId'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        modifiedAt: maps[i]['modifiedAt'],
      );
    });
  }

  Future<List<AreaModel>> getAreasByRouteId(String routeId) async {
    final db = await database;
    developer.log('Fetching areas for route: $routeId', name: 'DatabaseHelper');
    final List<Map<String, dynamic>> maps = await db.query(
      'areas',
      where: 'routeId = ?',
      whereArgs: [routeId],
    );
    developer.log('Fetched ${maps.length} areas for route: $routeId', name: 'DatabaseHelper');
    return List.generate(maps.length, (i) {
      return AreaModel(
        areaId: maps[i]['areaId'],
        areaName: maps[i]['areaName'],
        routeId: maps[i]['routeId'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        modifiedAt: maps[i]['modifiedAt'],
      );
    });
  }

  Future<void> insertAreas(List<AreaModel> areas) async {
    final db = await database;
    developer.log('Batch inserting ${areas.length} areas', name: 'DatabaseHelper');
    Batch batch = db.batch();
    for (var area in areas) {
      batch.insert(
        'areas',
        {
          'areaId': area.areaId,
          'areaName': area.areaName,
          'routeId': area.routeId,
          'createdAt': area.createdAt.toIso8601String(),
          'modifiedAt': area.modifiedAt,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    developer.log('${areas.length} areas inserted successfully', name: 'DatabaseHelper');
  }

  // UNIT OPERATIONS
  Future<int> insertUnit(UnitModel unit) async {
    final db = await database;
    developer.log('Inserting unit: ${unit.unitName}', name: 'DatabaseHelper');
    int result = await db.insert(
      'units',
      {
        'unitId': unit.unitId,
        'unitName': unit.unitName,
        'googleMap': unit.googleMap,
        'latitude': unit.latitude,
        'longitude': unit.longitude,
        'coinReading': unit.coinReading,
        'kebReading': unit.kebReading,
        'areaId': unit.areaId,
        'routeId': unit.routeId,
        'createdAt': unit.createdAt.toIso8601String(),
        'modifiedAt': unit.modifiedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Unit inserted successfully: ${unit.unitId}', name: 'DatabaseHelper');
    return result;
  }

  Future<List<UnitModel>> getUnits() async {
    final db = await database;
    developer.log('Fetching all units', name: 'DatabaseHelper');
    final List<Map<String, dynamic>> maps = await db.query('units');
    developer.log('Fetched ${maps.length} units', name: 'DatabaseHelper');
    return List.generate(maps.length, (i) {
      return UnitModel(
        unitId: maps[i]['unitId'],
        unitName: maps[i]['unitName'],
        googleMap: maps[i]['googleMap'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        coinReading: maps[i]['coinReading'],
        kebReading: maps[i]['kebReading'],
        areaId: maps[i]['areaId'],
        routeId: maps[i]['routeId'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        modifiedAt: maps[i]['modifiedAt'],
      );
    });
  }

  Future<List<UnitModel>> getUnitsByRouteAndArea(String routeId, String areaId) async {
    final db = await database;
    developer.log('Fetching units for route: $routeId and area: $areaId', name: 'DatabaseHelper');
    final List<Map<String, dynamic>> maps = await db.query(
      'units',
      where: 'routeId = ? AND areaId = ?',
      whereArgs: [routeId, areaId],
    );
    developer.log('Fetched ${maps.length} units for route: $routeId and area: $areaId', name: 'DatabaseHelper');
    return List.generate(maps.length, (i) {
      return UnitModel(
        unitId: maps[i]['unitId'],
        unitName: maps[i]['unitName'],
        googleMap: maps[i]['googleMap'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        coinReading: maps[i]['coinReading'],
        kebReading: maps[i]['kebReading'],
        areaId: maps[i]['areaId'],
        routeId: maps[i]['routeId'],
        createdAt: DateTime.parse(maps[i]['createdAt']),
        modifiedAt: maps[i]['modifiedAt'],
      );
    });
  }

  Future<void> insertUnits(List<UnitModel> units) async {
    final db = await database;
    developer.log('Batch inserting ${units.length} units', name: 'DatabaseHelper');
    Batch batch = db.batch();
    for (var unit in units) {
      batch.insert(
        'units',
        {
          'unitId': unit.unitId,
          'unitName': unit.unitName,
          'googleMap': unit.googleMap,
          'latitude': unit.latitude,
          'longitude': unit.longitude,
          'coinReading': unit.coinReading,
          'kebReading': unit.kebReading,
          'areaId': unit.areaId,
          'routeId': unit.routeId,
          'createdAt': unit.createdAt.toIso8601String(),
          'modifiedAt': unit.modifiedAt,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
    developer.log('${units.length} units inserted successfully', name: 'DatabaseHelper');
  }

  // ADDITIONAL UTILITY FUNCTIONS
  Future<void> clearAllTables() async {
    final db = await database;
    developer.log('Clearing all tables', name: 'DatabaseHelper');
    await db.delete('units');
    await db.delete('areas');
    await db.delete('routes');
    developer.log('All tables cleared successfully', name: 'DatabaseHelper');
  }

  Future<void> close() async {
    final db = await instance.database;
    developer.log('Closing database connection', name: 'DatabaseHelper');
    db.close();
    developer.log('Database connection closed', name: 'DatabaseHelper');
  }
}
///////////////////


class DataSyncService {
  final MeasurmentsRepo repository;
  final DatabaseHelper databaseHelper;

  DataSyncService({
    required this.repository,
    required this.databaseHelper,
  });

  Future<bool> downloadAllData() async {
    try {
      // Fetch routes
      final routeResponse = await repository.fetcchroutes();
      if (routeResponse.error || routeResponse.status != 200) {
        return false;
      }
      
      // Fetch areas
      final areaResponse = await repository.fetcharea();
      if (areaResponse.error || areaResponse.status != 200) {
        return false;
      }
      
      // Fetch units
      final unitResponse = await repository.fetchunit();
      if (unitResponse.error || unitResponse.status != 200) {
        return false;
      }
      
      // Save all data to database
      await databaseHelper.clearAllTables();
      await databaseHelper.insertRoutes(routeResponse.data!);
      await databaseHelper.insertAreas(areaResponse.data!);
      await databaseHelper.insertUnits(unitResponse.data!);
      
      return true;
    } catch (e) {
      debugPrint('Error downloading data: ${e.toString()}');
      return false;
    }
  }

  Future<List<RouteModel>> getLocalRoutes() async {
    return await databaseHelper.getRoutes();
  }
  
  Future<List<AreaModel>> getLocalAreas() async {
    return await databaseHelper.getAreas();
  }
  
  Future<List<AreaModel>> getLocalAreasByRouteId(String routeId) async {
    return await databaseHelper.getAreasByRouteId(routeId);
  }
  
  Future<List<UnitModel>> getLocalUnits() async {
    return await databaseHelper.getUnits();
  }
  
  Future<List<UnitModel>> getLocalUnitsByRouteAndArea(String routeId, String areaId) async {
    return await databaseHelper.getUnitsByRouteAndArea(routeId, areaId);
  }
}