import 'dart:convert';

class Todo {
  final String? title;
  final bool isCompleted;

  Todo({
    this.title,
    this.isCompleted = false,
  });

  Todo copyWith({
    String? title,
    bool? isCompleted,
  }) =>
      Todo(
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory Todo.fromJson(String str) => Todo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        title: json["title"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "isCompleted": isCompleted,
      };
}
