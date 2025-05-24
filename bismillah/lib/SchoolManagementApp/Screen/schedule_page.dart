import 'package:flutter/material.dart';
import 'package:bismillah/SchoolManagementApp/Models/schedule.dart';
import 'package:bismillah/SchoolManagementApp/Services/schedule_service.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Pelajaran')),
      body: FutureBuilder<List<Schedule>>(
        future: ScheduleService.fetchSchedules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada jadwal.'));
          }

          final schedules = snapshot.data!;

          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return ListTile(
                title: Text(schedule.subject),
                subtitle: Text('${schedule.teacher} | ${schedule.room}'),
                trailing: Text('${schedule.startTime} - ${schedule.endTime}'),
              );
            },
          );
        },
      ),
    );
  }
}
