import 'package:flutter/material.dart';
import 'package:bismillah/SchoolManagementApp/Services/schedule_service.dart';
import 'package:bismillah/SchoolManagementApp/Models/schedule.dart';
import 'package:bismillah/SchoolManagementApp/Screen/add_schedule_page.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List schedules = [];
  bool isLoading = true;

  Future<void> fetchSchedules() async {
    setState(() => isLoading = true);
    try {
      final data = await ScheduleService.fetchSchedules();
      setState(() {
        schedules = data.map((s) => s.toJson()).toList();
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal memuat jadwal')));
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteSchedule(int id) async {
    try {
      await ScheduleService.deleteSchedule(id);
      await fetchSchedules();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menghapus jadwal')));
    }
  }

  Future<void> editSchedule(Map<String, dynamic> oldData) async {
    final schedule = Schedule.fromJson(oldData);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddSchedulePage(schedule: schedule)),
    );

    // final result = await showDialog(
    //   context: context,
    //   builder:
    //       (_) => AlertDialog(
    //         title: const Text('Edit Jadwal'),
    //         content: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             TextField(
    //               controller: subjectController,
    //               decoration: const InputDecoration(
    //                 labelText: 'Mata Pelajaran',
    //               ),
    //             ),
    //             TextField(
    //               controller: teacherController,
    //               decoration: const InputDecoration(labelText: 'Guru'),
    //             ),
    //             TextField(
    //               controller: startController,
    //               decoration: const InputDecoration(labelText: 'Jam Mulai'),
    //             ),
    //             TextField(
    //               controller: endController,
    //               decoration: const InputDecoration(labelText: 'Jam Selesai'),
    //             ),
    //           ],
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: const Text('Batal'),
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               Navigator.pop(context, {
    //                 'subject': subjectController.text,
    //                 'teacher': teacherController.text,
    //                 'start_time': startController.text,
    //                 'end_time': endController.text,
    //               });
    //             },
    //             child: const Text('Simpan'),
    //           ),
    //         ],
    //       ),
    // );
    if (result == true) {
      await fetchSchedules(); // Refresh jadwal setelah update
    }
  }

  //   if (result != null) {
  //     try {
  //       await ScheduleService.updateSchedule(id, result);
  //       await fetchSchedules();
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(const SnackBar(content: Text('Gagal mengedit jadwal')));
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Jadwal')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return ListTile(
                    title: Text(schedule['subject']),
                    subtitle: Text(
                      '${schedule['start_time']} - ${schedule['end_time']}',
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editSchedule(schedule),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteSchedule(schedule['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
