class Employee {
  final String id;
  final String name;
  final String age;
  final String alamat;

  Employee({
    required this.id,
    required this.name,
    required this.age,
    required this.alamat,
  });

  // Convert a Employee into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age, 'alamat': alamat};
  }

  // Implement toString to make it easier to see information about
  // each Employee when using the print statement.
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, age: $age, alamat:$alamat}';
  }
}
