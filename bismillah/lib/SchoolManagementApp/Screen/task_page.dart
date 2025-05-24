import 'package:flutter/material.dart';
import '../Services/task_services.dart';
import '../Models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final data = await TaskService().fetchTasks();
      setState(() {
        tasks = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal memuat data tugas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Tugas')),
      body:
          tasks.isEmpty
              ? const Center(child: Text('Belum ada tugas'))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Icon(
                      task.isDone ? Icons.check_circle : Icons.circle_outlined,
                      color: task.isDone ? Colors.green : null,
                    ),
                  );
                },
              ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/task.dart';
// import '../services/task_services.dart';

// class TaskPage extends StatefulWidget {
//   const TaskPage({Key? key}) : super(key: key);

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   List<Task> tasks = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchTaskData();
//   }

//   Future<void> fetchTaskData() async {
//     try {
//       final data = await TaskService.fetchTasks();
//       setState(() {
//         tasks = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Gagal memuat data tugas')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Daftar Tugas')),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : tasks.isEmpty
//               ? const Center(child: Text('Tidak ada tugas.'))
//               : ListView.builder(
//                 itemCount: tasks.length,
//                 itemBuilder: (context, index) {
//                   final task = tasks[index];
//                   return ListTile(
//                     leading: Checkbox(
//                       value: task.isDone,
//                       onChanged: null, // akan kita isi nanti
//                     ),
//                     title: Text(
//                       task.title,
//                       style: TextStyle(
//                         decoration:
//                             task.isDone
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                       ),
//                     ),
//                     subtitle: Text(task.description ?? '-'),
//                     onTap: () {
//                       // nanti buat edit
//                     },
//                   );
//                 },
//               ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../Models/task.dart'; // Sesuaikan dengan lokasi model kamu
// import '../Services/task_services.dart'; // Sesuaikan juga

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   late Future<List<Task>> tasksFuture;

//   @override
//   void initState() {
//     super.initState();
//     tasksFuture = TaskService.fetchTasks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Daftar Tugas"), centerTitle: true),
//       body: FutureBuilder<List<Task>>(
//         future: tasksFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('Tidak ada tugas'));
//           }

//           final tasks = snapshot.data!;
//           return ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 elevation: 3,
//                 child: ListTile(
//                   title: Text(task.title),
//                   subtitle: Text('${task.subtitle} • ${task.name}'),
//                   trailing: Text(task.currentTime),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
