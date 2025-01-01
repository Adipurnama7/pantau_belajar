import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantau_belajar/models/schedule.dart';

class ScheduleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Menambahkan jadwal baru
  Future<void> addSchedule(Schedule schedule) async {
    try {
      DocumentReference docRef =
          await _db.collection('schedules').add(schedule.toMap());
      // Get the generated ID
      String generatedId = docRef.id;

      // Update the document with the ID field
      await docRef.update({'id': generatedId});
    } catch (e) {
      throw Exception('Failed to add schedule: $e');
    }
  }

  // Mendapatkan semua jadwal
  Future<List<Schedule>> getSchedules() async {
    try {
      QuerySnapshot snapshot = await _db.collection('schedules').get();
      return snapshot.docs
          .map((doc) => Schedule.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get schedules: $e');
    }
  }

  Stream<List<Schedule>> getSchedulesStream() {
    return _db.collection('schedules').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Schedule.fromMap(doc.data());
      }).toList();
    });
  }

  // Mendapatkan jadwal berdasarkan ID
  Future<Schedule?> getScheduleById(String id) async {
    try {
      DocumentSnapshot doc = await _db.collection('schedules').doc(id).get();
      if (doc.exists) {
        return Schedule.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception('Schedule not found');
      }
    } catch (e) {
      throw Exception('Failed to get schedule by ID: $e');
    }
  }

  // Mengupdate jadwal
  Future<void> updateSchedule(Schedule schedule) async {
    try {
      await _db
          .collection('schedules')
          .doc(schedule.id)
          .update(schedule.toMap());
    } catch (e) {
      throw Exception('Failed to update schedule: $e');
    }
  }

  // Menghapus jadwal
  Future<void> deleteSchedule(String id) async {
    try {
      DocumentReference scheduleRef = _db.collection('schedules').doc(id);
      QuerySnapshot subCollectionSnapshot =
          await scheduleRef.collection('detail_schedule').get();

      // Menghapus semua dokumen dalam subkoleksi
      for (QueryDocumentSnapshot doc in subCollectionSnapshot.docs) {
        await doc.reference.delete();
      }

      // Menghapus dokumen jadwal
      await scheduleRef.delete();
    } catch (e) {
      throw Exception('Failed to delete schedule: $e');
    }
  }

  // Fungsi untuk mendapatkan stream detail_schedule untuk hari ini
  Stream<List<Map<String, dynamic>>> getSchedulesForToday(String todayDay) {
    // Mendapatkan hari ini dalam format Indonesia (misalnya "senin", "selasa", dll)

    // Mengembalikan Stream dari Firestore
    return _db
        .collection('schedules')
        .snapshots()
        .asyncMap((schedulesSnapshot) async {
      List<Map<String, dynamic>> allDetailSchedules = [];

      // Iterasi untuk setiap dokumen schedule
      for (var scheduleDoc in schedulesSnapshot.docs) {
        // Query subkoleksi "detail_schedules" untuk setiap schedule
        var detailSchedulesSnapshot = await _db
            .collection('schedules')
            .doc(scheduleDoc.id)
            .collection('detail_schedule')
            .where('day', isEqualTo: todayDay) // Filter berdasarkan hari ini
            .get();

        // Menambahkan detail yang ditemukan ke list
        for (var detailDoc in detailSchedulesSnapshot.docs) {
          allDetailSchedules.add(detailDoc.data());
        }
      }

      return allDetailSchedules;
    });
  }
}
