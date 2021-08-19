import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_crud/main.dart';
import 'package:sqlite_crud/model/employe_model.dart';
import 'package:sqlite_crud/provider/employee_provider.dart';

class EditEmployee extends StatefulWidget {
  final Employee employee;
  EditEmployee(this.employee);

  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  // final Employee employee;

  TextEditingController alamatController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.employee.name;
    ageController.text = widget.employee.age;
    alamatController.text = widget.employee.alamat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _employee = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Employee'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                  child: Text(
                "Edit Empoyee",
                style: TextStyle(fontSize: 24),
              )),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Full Name",
                  hintText: "Full Name"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Usia",
                  hintText: "Usia"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "alamat",
                  hintText: "alamat"),
              // obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                _employee
                    .editEmployee(Employee(
                        id: widget.employee.id,
                        name: fullNameController.text,
                        age: ageController.text,
                        alamat: alamatController.text))
                    .then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage())));
              },
              child: Container(
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text("Edit Employee"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
