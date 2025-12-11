import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_12/models/habit_model.dart';

class HabitRepository {
  HabitRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('habits');

  Stream<List<HabitModel>> watchHabits({required String userId}) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('startDate', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => HabitModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addHabit({
    required String userId,
    required String name,
    required String frequency,
    required DateTime startDate,
  }) async {
    final doc = _collection.doc();
    final habit = HabitModel(
      id: doc.id,
      name: name,
      frequency: frequency,
      startDate: startDate,
      progress: {},
      userId: userId,
    );
    await doc.set(habit.toJson());
  }

  Future<void> toggleHabitProgress({
    required String habitId,
    required DateTime date,
    required bool isComplete,
  }) async {
    final doc = _collection.doc(habitId);
    await doc.set(
      {
        'progress': {HabitModel.dateKey(date): isComplete},
      },
      SetOptions(merge: true),
    );
  }

  Future<void> deleteHabit(String habitId) => _collection.doc(habitId).delete();
}
