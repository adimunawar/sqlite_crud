import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper = DbHelper._singleton();
  factory DbHelper() {
    return _dbHelper;
  }
  DbHelper._singleton();

  Future<Database> openDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'employee_db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE employee(id TEXT PRIMARY KEY, name TEXT, age TEXT, alamat TEXT)',
        );
      },
      version: 1,
    );
  }
}
