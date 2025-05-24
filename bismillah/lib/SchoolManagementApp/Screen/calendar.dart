// import 'package:bismillah/SchoolManagementApp/Models/model.dart';
// import 'package:flutter/material.dart';
// import 'package:bismillah/SchoolManagementApp/Utils/colors.dart';
// import 'package:intl/intl.dart';

// class Calendar extends StatefulWidget {
//   const Calendar({super.key});

//   @override
//   State<Calendar> createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   DateTime selectedDate = DateTime(2025, 10, 10);
//   late Future<List<Task>> futureTasks;

//   @override
//   void initState() {
//     super.initState();
//     futureTasks = fetchTasksFromAPI();
//   }

//   Future<List<Task>> fetchTasksFromAPI() async {
//     // TODO: Implement your API fetch logic here using http
//     // Example dummy fetch:
//     await Future.delayed(Duration(seconds: 1));
//     return []; // replace this with parsed API response
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           alignment: Alignment.topCenter,
//           color: kCardColor,
//           height: size.height,
//           child: SafeArea(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_today, color: Colors.grey),
//                     const SizedBox(width: 15),
//                     RichText(
//                       text: TextSpan(
//                         text: "Oct",
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.w900,
//                           color: textColor,
//                         ),
//                         children: const [
//                           TextSpan(
//                             text: "2025",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   "Today",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: secondTextColor,
//                     fontSize: 18,
//                     letterSpacing: -0.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 130,
//           child: Container(
//             height: size.height - 160,
//             width: size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 20,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(7, (index) {
//                       final date = DateTime(2025, 10, 7 + index);
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedDate = date;
//                           });
//                         },
//                         child: myCalendar(
//                           DateFormat('E').format(date).substring(0, 1),
//                           date.day,
//                           date.day == selectedDate.day,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 Expanded(
//                   child: FutureBuilder<List<Task>>(
//                     future: futureTasks,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(child: Text("Error: ${snapshot.error}"));
//                       }

//                       final filteredTasks =
//                           snapshot.data!.where((task) {
//                             return task.date ==
//                                 DateFormat('yyyy-MM-dd').format(selectedDate);
//                           }).toList();

//                       return SingleChildScrollView(
//                         child: Column(
//                           children: List.generate(filteredTasks.length, (
//                             index,
//                           ) {
//                             final task = filteredTasks[index];
//                             return Container(
//                               margin: const EdgeInsets.only(bottom: 25),
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 20,
//                                     height: 13,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.orangeAccent,
//                                       borderRadius: BorderRadius.horizontal(
//                                         right: Radius.circular(15),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           task.title,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         Text(task.subtitle),
//                                         Text("${task.name} - ${task.room}"),
//                                         Text(
//                                           "${task.currentTime} (${task.remainingTime})",
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Container myCalendar(String weekDay, int date, bool isActive) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isActive ? secondTextColor : Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       height: 75,
//       width: 50,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             weekDay,
//             style: const TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             date.toString(),
//             style: TextStyle(
//               color: isActive ? Colors.white : Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
