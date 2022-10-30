import 'dart:typed_data';
import 'package:animal_biography/helpers/images_api_helper.dart';
import 'package:animal_biography/modals/animal.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../global.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  final String dbName = "animalsData.db";
  final String colId = "id";
  final String colTime = "time";
  final String colPrice = "price";
  final String colImage = "image";
  final String colName = "name";
  final String colDescription = "description";
  final String colCategory = "category";

  Database? db;

  Future<void> initDB({required String tableName}) async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(path, version: 1, onCreate: (db, version) {});

    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTime TEXT,$colPrice TEXT,$colImage BLOB)");
  }

  insertSubscriptionRecord(
      {required String tableName, required List<Subscription> data}) async {
    await initDB(tableName: tableName);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < data.length; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(search: "${i + 1} wild animal");

      String query =
          "INSERT INTO $tableName($colTime, $colPrice,$colImage) VALUES(?, ?,?)";
      List args = [data[i].time, data[i].price, image];

      await db?.rawInsert(query, args);
    }
    prefs.setBool(tableName, true);
  }

  Future<List<SubscriptionDB>> fetchAllSubscriptionRecords(
      {required String tableName, required List<Subscription> data}) async {
    await initDB(tableName: tableName);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isInserted = prefs.getBool(tableName) ?? false;

    (isInserted)
        ? await updateImages(tableName: tableName, length: data.length)
        : await insertSubscriptionRecord(tableName: tableName, data: data);

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<SubscriptionDB> animalsList =
        res.map((e) => SubscriptionDB.fromData(e)).toList();

    return animalsList;
  }

  Future<void> updateImages(
      {required String tableName, required int length}) async {
    for (int i = 0; i < length; i++) {
      Uint8List? image = await ImageAPIHelper.imageAPIHelper
          .getImage(search: "${i + 1} wild animal");

      String query =
          "UPDATE $tableName SET $colImage = ? WHERE $colId = ${i + 1}";
      List args = [image];
      await db?.rawUpdate(query, args);
    }
  }

  insertAnimalData(
      {required String tableName, required List<Animal> data}) async {
    await db?.execute(
        "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT,$colDescription TEXT,$colImage BLOB,$colCategory TEXT)");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      for (int i = 0; i < data.length; i++) {
        Uint8List image =
            (await rootBundle.load("assets/images/${data[i].name}.jpg"))
                .buffer
                .asUint8List();

        String query =
            "INSERT INTO $tableName($colName, $colDescription,$colImage,$colCategory) VALUES(?, ?,?,?)";
        List args = [
          data[i].name,
          data[i].description,
          image,
          data[i].category
        ];

        await db?.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<AnimalDB>> fetchAllAnimalData(
      {required String tableName, required List<Animal> data}) async {
    await insertAnimalData(tableName: tableName, data: data);

    String query = (Global.category == "")
        ? "SELECT * FROM $tableName"
        : "SELECT * FROM $tableName WHERE $colCategory LIKE '%${Global.category}%'";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<AnimalDB> animalsList = res.map((e) => AnimalDB.fromData(e)).toList();

    return animalsList;
  }
}
