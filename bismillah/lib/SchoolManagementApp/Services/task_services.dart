import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bismillah/SchoolManagementApp/Models/model.dart';

class TaskService {
  static Future<List<Task>> fetchTasks() async {
    print("Memulai fetchTasks...");
    final response = await http.get(
      Uri.parse('http://192.168.101.94:8000/api/tasks'),
    );

    print("Status code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}

// class TaskService {
//   static Future<List<Task>> fetchTasks() async {
//     final response = await http.get(
//       Uri.parse('http://192.168.101.94:8000/api/tasks'),
//     );

//     if (response.statusCode == 200) {
//       List jsonData = jsonDecode(response.body);
//       print("Task JSON: $jsonData"); // Debug output
//       return jsonData.map((e) => Task.fromJson(e)).toList();
//     } else {
//       print("Gagal fetch task, status: ${response.statusCode}");
//       throw Exception('Failed to load tasks');
//     }
//   }
// }
