import 'package:flutter/cupertino.dart';
import 'package:sqlite_crud/model/employe_model.dart';
import 'package:sqlite_crud/services/employee_services.dart';

class EmployeeProvider extends ChangeNotifier {
  bool isLoding = false;
  List<Employee> _data = [];
  List<Employee> get data => _data;

  Future<bool> addEmployee(Employee employee) async {
    try {
      isLoding = true;
      notifyListeners();
      await EmployeeService.addEmployee(employee);
      isLoding = false;
      notifyListeners();
      return true;
    } catch (e) {
      // _status = Status.Unauthenticated;
      print(e);
      isLoding = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getEmployee() async {
    try {
      List<Employee> employee = await EmployeeService.getEmployees();
      _data = employee;
      notifyListeners();
      print("berhasil get data employee");
    } catch (e) {
      print(e);
    }
  }

  Future<void> editEmployee(Employee employee) async {
    try {
      isLoding = true;
      await EmployeeService.updateDog(employee);
      notifyListeners();
      print("berhasil Edit Employee");
      isLoding = false;
    } catch (e) {
      isLoding = false;
      print(e);
    }
  }

  void deleteEmployee(String id) async {
    await EmployeeService.deleteEmployee(id).then((value) => print("berhasil"));
  }
}
