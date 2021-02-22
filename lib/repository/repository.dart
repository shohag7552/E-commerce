import 'package:e_commerce/repository/db_connection.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _connection;
  String _baseUrl = "https://antopolis.tech/task-assets/ecom/ecom.json";
  var headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Repository() {
    _connection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _connection.initDatabase();

    return _database;
  }

  httpGet(String api) async {
    return await http.get(_baseUrl + '/' + api);
  }

  httpGetById(String api, categoryId) async {
    return await http.get(_baseUrl + '/' + api + '/' + categoryId.toString());
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }
    deleteLocalById(table, id) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id = id");
  }

  deleteLocal(table) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table");
  }
}