class Schedule {
  final int id;
  final String day;
  final String subject;
  final String teacher;
  final String room;
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.day,
    required this.subject,
    required this.teacher,
    required this.room,
    required this.startTime,
    required this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      day: json['day'],
      subject: json['subject'],
      teacher: json['teacher'],
      room: json['room'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'subject': subject,
      'teacher': teacher,
      'room': room,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
