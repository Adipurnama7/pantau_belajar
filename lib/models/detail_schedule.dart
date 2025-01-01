import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailSchedule {
  final String id;
  final String uid; // User ID
  final String scheduleId; // Schedule ID
  final String title;
  final String day; // Day of the schedule
  final TimeOfDay startTime; // Start time of the schedule
  final TimeOfDay endTime; // End time of the schedule

  DetailSchedule({
    required this.id,
    required this.uid,
    required this.title,
    required this.scheduleId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  // Convert Firestore document to DetailSchedule object
  factory DetailSchedule.fromMap(Map<String, dynamic> map) {
    return DetailSchedule(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      scheduleId: map['scheduleId'] ?? '',
      title: map['title'] ?? '',
      day: map['day'] ?? '',
      startTime: _timeOfDayFromTimestamp(map['startTime']),
      endTime: _timeOfDayFromTimestamp(map['endTime']),
    );
  }

  // Convert DetailSchedule object to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'scheduleId': scheduleId,
      'day': day,
      'startTime': _timeOfDayToTimestamp(startTime),
      'endTime': _timeOfDayToTimestamp(endTime),
    };
  }

  // Helper: Convert Firestore Timestamp to TimeOfDay
  static TimeOfDay _timeOfDayFromTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }

  // Helper: Convert TimeOfDay to Firestore Timestamp
  static Timestamp _timeOfDayToTimestamp(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final date = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return Timestamp.fromDate(date);
  }
}
