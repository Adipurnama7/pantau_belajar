import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/detail_schedule.dart';

class DetailScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Reference to the collection
  CollectionReference get _collection => _firestore.collection('schedules');

  // Add a new DetailSchedule
  Future<void> addDetailSchedule(DetailSchedule detailSchedule) async {
    try {
      // Generate ID for the new document
      String generatedId = _collection
          .doc(detailSchedule.scheduleId)
          .collection('detail_schedule')
          .doc()
          .id; // Generate ID

      // Add the new detail schedule document
      await _collection
          .doc(detailSchedule.scheduleId)
          .collection('detail_schedule')
          .doc(generatedId)
          .set(detailSchedule.toMap()..['id'] = generatedId);
    } catch (e) {
      throw Exception('Failed to add detail schedule: $e');
    }
  }

  // Update an existing DetailSchedule
  Future<void> updateDetailSchedule(DetailSchedule detailSchedule) async {
    try {
      await _collection
          .doc(detailSchedule.scheduleId)
          .collection('detail_schedule')
          .doc(detailSchedule.id)
          .update(detailSchedule.toMap());
    } catch (e) {
      throw Exception('Failed to update detail schedule: $e');
    }
  }

  // Delete a DetailSchedule
  Future<void> deleteDetailSchedule(
      String scheduleId, String detailScheduleId) async {
    try {
      // Delete the specific document in the 'detail_schedule' subcollection
      await _collection
          .doc(scheduleId)
          .collection('detail_schedule')
          .doc(detailScheduleId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete detail schedule: $e');
    }
  }

  // Get a single DetailSchedule by ID
  Future<DetailSchedule?> getDetailScheduleById(
      String scheduleId, String detailScheduleId) async {
    try {
      final doc = await _collection
          .doc(scheduleId)
          .collection('detail_schedule')
          .doc(detailScheduleId)
          .get();
      if (doc.exists) {
        return DetailSchedule.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get detail schedule: $e');
    }
  }

  // Get all DetailSchedules for a specific schedule
  Future<List<DetailSchedule>> getDetailSchedulesByScheduleId(
      String scheduleId) async {
    try {
      final querySnapshot =
          await _collection.doc(scheduleId).collection('detail_schedule').get();
      return querySnapshot.docs.map((doc) {
        return DetailSchedule.fromMap(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Failed to get detail schedules: $e');
    }
  }

  Stream<List<DetailSchedule>> getDetailScheduleByScheduleIdStream(
      String scheduleId) {
    try {
      return _collection
          .doc(scheduleId)
          .collection('detail_schedule')
          .snapshots() // This provides real-time updates
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => DetailSchedule.fromMap(doc.data()))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get detail schedules stream: $e');
    }
  }

  // Delete all DetailSchedules for a specific schedule (if you want to delete all)
  Future<void> deleteAllDetailSchedules(String scheduleId) async {
    try {
      // Get all detail schedules for this schedule
      QuerySnapshot querySnapshot =
          await _collection.doc(scheduleId).collection('detail_schedule').get();

      // Delete each document in the 'detail_schedule' subcollection
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete all detail schedules: $e');
    }
  }
}
