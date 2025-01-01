import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String uid;
  final String title;
  final String heading;
  final String subheading;
  final String description;
  final Timestamp timestamp;

  Schedule({
    required this.title,
    required this.heading,
    required this.subheading,
    required this.description,
    required this.id,
    required this.uid,
    required this.timestamp,
  });

  // Method untuk mengubah data menjadi Map, bisa digunakan untuk serialisasi atau penyimpanan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'heading': heading,
      'subheading': subheading,
      'description': description,
      'timestamp': timestamp,
    };
  }

  // Method untuk membuat Schedule dari Map (misalnya dari database atau API)
  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'],
      uid: map['uid'],
      title: map['title'],
      heading: map['heading'],
      subheading: map['subheading'],
      description: map['description'],
      timestamp: map['timestamp'],
    );
  }
}
