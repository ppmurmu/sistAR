import 'package:meta/meta.dart';
import 'dart:convert';

Task taskFromMap(Map<String, dynamic> map, String id) => Task.fromMap(map, id);

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    required this.taskName,
    required this.description,
    required this.status,
    required this.username,
    required this.id,
  });

  String taskName;
  String description;
  String status;
  String username;
  String id;

  factory Task.fromMap(Map<String, dynamic> map, String id) => Task(
      taskName: map["task_name"],
      description: map["description"],
      status: map["status"],
      username: map["username"],
      id: id);

  Map<String, dynamic> toJson() => {
        "task_name": taskName == null ? null : taskName,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
        "username": username == null ? null : username,
      };
}
