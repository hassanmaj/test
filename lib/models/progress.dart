class Progress {
  final int? id;
  final int studentId;
  final String surah;
  final int startAyah;
  final int endAyah;
  final String evaluation;
  final DateTime date;

  Progress({this.id, required this.studentId, required this.surah, required this.startAyah, required this.endAyah, required this.evaluation, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'surah': surah,
      'startAyah': startAyah,
      'endAyah': endAyah,
      'evaluation': evaluation,
      'date': date.toIso8601String(),
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'],
      studentId: map['studentId'],
      surah: map['surah'],
      startAyah: map['startAyah'],
      endAyah: map['endAyah'],
      evaluation: map['evaluation'],
      date: DateTime.parse(map['date']),
    );
  }
}