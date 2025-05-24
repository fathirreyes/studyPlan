import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bismillah/SchoolManagementApp/Models/schedule.dart';

class ScheduleService {
  static const baseUrl = 'http://192.168.101.94:8000/api/schedules';

  static Future<List<Schedule>> fetchSchedules() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Schedule.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  static Future<List<Schedule>> fetchTodaySchedules() async {
    final response = await http.get(Uri.parse('$baseUrl/today'));
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Schedule.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load today\'s schedules');
    }
  }

  static Future<void> deleteSchedule(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete schedule');
    }
  }

  static Future<void> updateSchedule(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update schedule');
    }
  }
}
