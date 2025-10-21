import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Sqldb {
  var databaseFactory = databaseFactoryFfi;
  String databaseName = "OIURegister";
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initWinDB();
      return _db;
    }
    return _db;
  }

  Future<Database?> initWinDB() async {
    sqfliteFfiInit();
    Directory dbpath = await getApplicationDocumentsDirectory();
    String fullPath = join(dbpath.path, "$databaseName.db");
    Database db = await databaseFactory.openDatabase(
      fullPath,
      options: OpenDatabaseOptions(onCreate: onCreate, version: 3),
    );
    return db;
  }

  Future onCreate(Database db, int version) async {
    await db.transaction((Transaction txn) async {
      await txn.execute('''
    CREATE TABLE `student`(
      studentid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
      studentname TEXT NOT NULL UNIQUE ,
      universityid INTEGER NOT NULL UNIQUE ,
      birthday INTEGER NOT NULL,
      faculty TEXT NOT NULL DEFAULT 'Computer Science And Information Technology', 
      facultydep TEXT NOT NULL, 
      universityYear TEXT NOT NULL,
      skill TEXT NOT NULL DEFAULT 'CS'
    )
''');
      await txn.execute('''
  CREATE TABLE `users`(
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
  email TEXT NOT NULL UNIQUE ,
  username TEXT NOT NULL UNIQUE ,
  password TEXT NOT NULL , 
  retypepassword TEXT NOT NULL
  )
''');
    });
  }

  multipleDeleteData(
    String table,
    String queryId,
    String placeholder,
    List<int> ids,
  ) async {
    Database? mydb = await db;
    int response = await mydb!.delete(
      table,
      where: '$queryId IN ($placeholder)',
      whereArgs: ids,
    );
    return response;
  }

  readData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawQuery(sql);
    return response;
  }

  createData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDatabase() async {
    if (Platform.isAndroid) {
      String databasepath = await getDatabasesPath();
      String path = join(databasepath, "$databaseName.db");
      await deleteDatabase(path);
    } else {
      sqfliteFfiInit();
      Directory databasepath = (await getApplicationDocumentsDirectory());
      String path = join(databasepath.path, "$databaseName.db");
      await databaseFactory.deleteDatabase(path);
    }
  }
}
