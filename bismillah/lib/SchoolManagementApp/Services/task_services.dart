import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/task.dart';

class TaskService {
  static const String baseUrl = 'http://192.168.101.94:8000/api';

  // Ambil semua task dari API
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Tambah task baru
  static Future<void> addTask(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 201) {
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      throw Exception('Failed to add task');
    }
  }

  // Edit task
  static Future<void> updateTask(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit task');
    }
  }

  // Tandai task sebagai done / undone
  static Future<void> markTaskDone(int id, bool isDone) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'is_done': isDone ? 1 : 0}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task status');
    }
  }

  Future<void> createTask({
    required String title,
    required String description,
    String? deadline,
  }) async {
    final Map<String, dynamic> bodyData = {
      'title': title,
      'description': description,
    };

    if (deadline != null && deadline.isNotEmpty) {
      bodyData['deadline'] = deadline;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyData),
    );

    if (response.statusCode != 201) {
      print('GAGAL: ${response.body}');
      throw Exception('Gagal membuat task');
    }
  }
}
