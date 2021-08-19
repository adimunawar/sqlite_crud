import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_crud/db/db_helper.dart';
import 'package:sqlite_crud/model/employe_model.dart';
import 'package:sqlite_crud/provider/employee_provider.dart';
import 'package:sqlite_crud/view/detail_page.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Employee"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Center(child: Text("+")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEmployeePage()));
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: FutureBuilder(
            future: Provider.of<EmployeeProvider>(context, listen: false)
                .getEmployee(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Consumer<EmployeeProvider>(
                builder: (context, data, _) {
                  return ListView.builder(
                      itemCount: data.data.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(employee: data.data[i])));
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (DismissDirection direction) async {
                              final bool res = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Konfirmasi"),
                                    content: Text('Kamu Yakin'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text('HAPUS'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text('BATALKAN'),
                                      )
                                    ],
                                  );
                                },
                              );
                              return res;
                            },
                            onDismissed: (value) {
                              Provider.of<EmployeeProvider>(context,
                                      listen: false)
                                  .deleteEmployee(data.data[i].id);
                            },
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("nama :"),
                                      Text(data.data[i].name),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Usia :"),
                                      Text(data.data[i].age),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ),
                        );
                      });
                },
              );
            }),
      ),
    );
  }
}

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController alamatController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    final employee = Provider.of<EmployeeProvider>(context);
    final DbHelper _helper = new DbHelper();

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
                "Register",
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
                  var uuid = Uuid();
                  String userId = uuid.v4();
                  employee
                      .addEmployee(Employee(
                          id: userId,
                          name: fullNameController.text,
                          age: ageController.text,
                          alamat: alamatController.text))
                      .then((value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage())));
                },
                child: context.watch<EmployeeProvider>().isLoding
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ))))
          ],
        ),
      ),
    );
  }
}
