import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id;
  final String? title;
  final bool isCompleted;
  final int? timestamp;

  Todo({
    this.id,
    this.title,
    this.isCompleted = false,
    this.timestamp,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    int? timestamp,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        timestamp: timestamp ?? this.timestamp,
      );

  factory Todo.fromJson(String str) => Todo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "isCompleted": isCompleted,
      };

  factory Todo.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Todo(
      id: snapshot.id,
      title: snapshot['title'],
      isCompleted: snapshot["isCompleted"],
      timestamp: (snapshot["timestamp"] as Timestamp?)?.millisecondsSinceEpoch,
    );
  }
}
