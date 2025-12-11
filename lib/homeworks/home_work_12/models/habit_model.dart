import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/constants/habit_texts.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');

class HabitModel extends Equatable {
  const HabitModel({
    required this.id,
    required this.name,
    required this.frequency,
    required this.startDate,
    required this.progress,
    required this.userId,
  });

  final String id;
  final String name;
  final String frequency;
  final DateTime startDate;
  final Map<String, bool> progress;
  final String userId;

  factory HabitModel.fromJson(Map<String, dynamic> json, String id) {
    final progressMap = <String, bool>{};
    final progressData = json['progress'] as Map<String, dynamic>? ?? {};
    for (final entry in progressData.entries) {
      final value = entry.value;
      progressMap[entry.key] = value is bool ? value : value == true;
    }
    return HabitModel(
      id: id,
      name: json['name'] as String? ?? HabitTexts.defaultHabitName,
      frequency: json['frequency'] as String? ?? HabitTexts.frequencyDaily,
      startDate: DateTime.tryParse(json['startDate'] as String? ?? '') ??
          DateTime.now(),
      progress: progressMap,
      userId: json['userId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'frequency': frequency,
      'startDate': _dateFormat.format(startDate),
      'progress': progress,
      'userId': userId,
    };
  }

  bool get isCompletedToday {
    final todayKey = _dateFormat.format(DateTime.now());
    return progress[todayKey] ?? false;
  }

  double get completionPercent {
    if (progress.isEmpty) return 0;
    final total = progress.values.length;
    if (total == 0) return 0;
    final completed = progress.values.where((value) => value).length;
    return completed / total;
  }

  HabitModel copyWith({
    String? id,
    String? name,
    String? frequency,
    DateTime? startDate,
    Map<String, bool>? progress,
    String? userId,
  }) {
    return HabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      progress: progress ?? this.progress,
      userId: userId ?? this.userId,
    );
  }

  static String dateKey(DateTime date) => _dateFormat.format(date);

  @override
  List<Object?> get props => [id, name, frequency, startDate, progress, userId];
}
