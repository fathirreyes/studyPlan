import 'package:bismillah/SchoolManagementApp/Utils/colors.dart';
import 'package:flutter/material.dart';
import '../Models/task.dart';
import '../Services/task_services.dart';
import '../Services/schedule_service.dart'; // tambahkan ini
import '../Models/schedule.dart'; // tambahkan ini
import '../Screen/schedule_list_page.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  List<Task> tasks = [];
  List<Schedule> schedules = []; // tambahkan ini
  bool isLoading = true;
  bool isScheduleLoading = true; // tambahkan ini

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadSchedules(); // tambahkan ini
  }

  void loadTasks() async {
    try {
      final fetchedTasks = await TaskService().fetchTasks(); // non-static call
      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching tasks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadSchedules() async {
    final fetchedSchedules = await ScheduleService.fetchSchedules();
    setState(() {
      schedules = fetchedSchedules;
      isScheduleLoading = false;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kheaderColor,
      body: Stack(
        children: [
          Container(
            color: kheaderColor,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: "Wed",
                        style: TextStyle(
                          color: textColor,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                        ),
                        children: [
                          TextSpan(
                            text: "10 Oct",
                            style: TextStyle(
                              letterSpacing: -1,
                              color: textColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 7,
                              spreadRadius: 7,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/9156/9156755.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello Uwih,",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w900,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Here is a list of schedule\nyou need to check...",
                            style: TextStyle(
                              height: 1.8,
                              color: textColor.withOpacity(0.75),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ScheduleListPage(),
                                ),
                              );
                            },
                            icon: Icon(Icons.list),
                            label: Text("Lihat Semua Jadwal"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 220,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: [
                  seeAllItems("TODAY CLASSES", schedules.length),
                  const SizedBox(height: 20),
                  isScheduleLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                        children:
                            schedules.map((schedule) {
                              final timeRange =
                                  "${schedule.startTime} - ${schedule.endTime}";
                              return todayclassesItems(
                                timeRange,
                                schedule.subject,
                                "", // gambar profil
                                schedule.teacher,
                                schedule.room,
                                schedule.day,
                              );
                            }).toList(),
                      ),
                  const SizedBox(height: 20),
                  seeAllItems("YOUR TASK", tasks.length),
                  SizedBox(
                    height: 170,
                    child:
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];

                                String remainingTimeText;
                                if (task.deadline != null) {
                                  final deadlineDate = DateTime.tryParse(
                                    task.deadline!,
                                  );
                                  if (deadlineDate != null) {
                                    final now = DateTime.now();
                                    final difference =
                                        deadlineDate.difference(now).inDays;
                                    remainingTimeText = "$difference days left";
                                  } else {
                                    remainingTimeText = "Invalid date";
                                  }
                                } else {
                                  remainingTimeText = "No deadline";
                                }

                                return yourTaskItems(
                                  Colors.blue,
                                  remainingTimeText,
                                  task.title,
                                );
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container yourTaskItems(Color color, String remainingTime, String title) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 170,
      width: 175,
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deadline",
            style: TextStyle(fontSize: 15, color: Colors.black26),
          ),
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 5),
              Text(
                remainingTime,
                style: const TextStyle(fontSize: 17, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 130,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Container yourTaskItems(Color color, String remainingTime, String title) {
  //   return Container(
  //     margin: EdgeInsets.only(right: 15),
  //     padding: EdgeInsets.all(12),
  //     height: 170,
  //     width: 175,
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.05),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Deadline", style: TextStyle(fontSize: 15, color: Colors.black26)),
  //         Row(
  //           children: [
  //             CircleAvatar(radius: 4, backgroundColor: color),
  //             const SizedBox(width: 5),
  //             Text(
  //               "$remainingTime days left",
  //               style: TextStyle(fontSize: 17, color: Colors.black54),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 20),
  //         SizedBox(
  //           width: 130,
  //           child: Text(
  //             title,
  //             maxLines: 3,
  //             overflow: TextOverflow.ellipsis,
  //             style: const TextStyle(
  //               fontSize: 18,
  //               color: Colors.black54,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Row seeAllItems(title, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "($number)",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Text(
          "See All",
          style: TextStyle(
            color: secondTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Container todayclassesItems(
    String time,
    String title,
    String profile,
    String name,
    String room,
    String day,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 110,
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // Waktu dan AM
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(time, style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          Container(width: 1, height: 60, color: Colors.grey.withOpacity(0.5)),

          const SizedBox(width: 10),

          // Bagian kanan (title, lokasi, nama)
          Expanded(
            // <--- Ini penting agar bagian kanan menyesuaikan sisa space
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          room,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                        radius: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
