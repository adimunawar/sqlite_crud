import 'package:flutter/material.dart';
import 'package:sqlite_crud/model/employe_model.dart';
import 'package:sqlite_crud/view/edit_page.dart';

class DetailPage extends StatelessWidget {
  final Employee employee;
  const DetailPage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("detail Page"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Nama :"),
                Text(employee.name),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("usia :"),
                Text(employee.age),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("alamat :"),
                Text(employee.alamat),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditEmployee(employee)));
              },
              child: Container(
                height: 30,
                color: Colors.blue,
                child: Center(
                  child: Text("Edit"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
