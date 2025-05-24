import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bismillah/SchoolManagementApp/Models/schedule.dart';

class AddSchedulePage extends StatefulWidget {
  final Schedule? schedule; // Jika null = tambah, jika tidak null = edit

  AddSchedulePage({this.schedule});

  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final subjectController = TextEditingController();
  final teacherController = TextEditingController();
  final roomController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedDay;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      final s = widget.schedule!;
      subjectController.text = s.subject;
      teacherController.text = s.teacher;
      roomController.text = s.room;
      selectedDay = s.day;

      final startParts = s.startTime.split(":");
      final endParts = s.endTime.split(":");

      startTime = TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      );
      endTime = TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      );
    }
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime)
          startTime = picked;
        else
          endTime = picked;
      });
    }
  }

  Future<void> submitSchedule() async {
    if (selectedDay == null || startTime == null || endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lengkapi semua data termasuk hari dan waktu')),
      );
      return;
    }

    final body = jsonEncode({
      'day': selectedDay,
      'subject': subjectController.text,
      'teacher': teacherController.text,
      'room': roomController.text,
      'start_time':
          '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}',
      'end_time':
          '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}',
    });

    final isEdit = widget.schedule != null;
    final url =
        isEdit
            ? Uri.parse(
              'http://192.168.101.94:8000/api/schedules/${widget.schedule!.id}',
            )
            : Uri.parse('http://192.168.101.94:8000/api/schedules');

    final response =
        isEdit
            ? await http.put(
              url,
              headers: {'Content-Type': 'application/json'},
              body: body,
            )
            : await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: body,
            );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan jadwal: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.schedule != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Jadwal' : 'Tambah Jadwal')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDay,
              decoration: InputDecoration(labelText: 'Hari'),
              items:
                  days
                      .map(
                        (day) => DropdownMenuItem(value: day, child: Text(day)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => selectedDay = value),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Mata Pelajaran'),
            ),
            TextField(
              controller: teacherController,
              decoration: InputDecoration(labelText: 'Guru'),
            ),
            TextField(
              controller: roomController,
              decoration: InputDecoration(labelText: 'Ruangan'),
            ),
            ListTile(
              title: Text(
                startTime == null
                    ? 'Pilih Waktu Mulai'
                    : 'Mulai: ${startTime!.format(context)}',
              ),
              trailing: Icon(Icons.access_time),
              onTap: () => selectTime(context, true),
            ),
            ListTile(
              title: Text(
                endTime == null
                    ? 'Pilih Waktu Selesai'
                    : 'Selesai: ${endTime!.format(context)}',
              ),
              trailing: Icon(Icons.access_time),
              onTap: () => selectTime(context, false),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitSchedule,
              child: Text(isEdit ? 'Perbarui Jadwal' : 'Simpan Jadwal'),
            ),
          ],
        ),
      ),
    );
  }
}
