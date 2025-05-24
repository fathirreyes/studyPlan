class Task {
  final int id;
  final String title;
  final String subtitle;
  final String name;
  final String room;
  final String currentTime; // Sesuai dengan Laravel (string)
  final String remainingTime; // Sesuai dengan Laravel (string)
  final DateTime createdAt; // Tambahkan ini

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.name,
    required this.room,
    required this.currentTime,
    required this.remainingTime,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      name: json['name'],
      room: json['room'],
      currentTime: json['current_time'], // Perhatikan underscore
      remainingTime: json['remaining_time'], // Perhatikan underscore
      createdAt: DateTime.parse(json['created_at']), // Parse timestamp
    );
  }
}

  // Map<String, dynamic> toJson() {
  //   return {
  //     'currentTime': currentTime,
  //     'remainingTime': remainingTime,
  //     'title': title,
  //     'subtitle': subtitle,
  //     'name': name,
  //     'room': room,
  //     'date': date.toIso8601String(), // ✅ Simpan jadi format ISO String
  //   };
  // }


// List<Task> tasks = [
//   Task(
//     currentTime: "07.00",
//     remainingTime: "1 h 45 min",
//     title: "Typography",
//     subtitle: "PAB",
//     name: "pak asep",
//     room: "Lab Comp / Classroom",
//   ),
//   Task(
//     currentTime: "07.00",
//     remainingTime: "1 h 45 min",
//     title: "Typography",
//     subtitle: "PAB",
//     name: "pak asep",
//     room: "Lab Comp / Classroom",
//   ),
//   Task(
//     currentTime: "07.00",
//     remainingTime: "1 h 45 min",
//     title: "Typography",
//     subtitle: "PAB",
//     name: "pak asep",
//     room: "Lab Comp / Classroom",
//   ),
// ];
