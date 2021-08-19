import 'package:sqflite/sql.dart';
import 'package:sqlite_crud/db/db_helper.dart';
import 'package:sqlite_crud/model/employe_model.dart';

class EmployeeService {
  static DbHelper _helper = new DbHelper();
  static Future<void> addEmployee(Employee employee) async {
    final db = await _helper.openDb();
    await db
        .insert(
          'employee',
          employee.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => {print("berhasil")})
        .catchError((err) {
      print("gagal,");
    });
  }

  static Future<List<Employee>> getEmployees() async {
    final db = await _helper.openDb();
    final List<Map<String, dynamic>> maps = await db.query('employee');
    return List.generate(maps.length, (i) {
      return Employee(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
          alamat: maps[i]['alamat']);
    });
  }

  static Future<void> updateDog(Employee employee) async {
    final db = await _helper.openDb();

    await db.update(
      'employee',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  static Future<void> deleteEmployee(String id) async {
    final db = await _helper.openDb();

    await db.delete(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
