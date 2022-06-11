import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    required this.received,
    required this.available,
    required this.data,
  });

  bool received;
  bool available;
  List<Task> data;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        received: json["received"],
        available: json["available"],
        data: List<Task>.from(json["data"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "received": received,
        "available": available,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.taskTitle,
    required this.taskDesc,
    required this.taskType,
    required this.taskDate,
    required this.taskCompleted,
    required this.v,
  });

  String id;
  String taskId;
  String userId;
  String taskTitle;
  String taskDesc;
  String taskType;
  String taskDate;
  bool taskCompleted;
  int v;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        taskId: json["task_id"],
        userId: json["user_id"],
        taskTitle: json["task_title"],
        taskDesc: json["task_desc"],
        taskType: json["task_type"],
        taskDate: json["task_date"],
        taskCompleted: json["task_completed"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task_id": taskId,
        "user_id": userId,
        "task_title": taskTitle,
        "task_desc": taskDesc,
        "task_type": taskType,
        "task_date": taskDate,
        "task_completed": taskCompleted,
        "__v": v,
      };
}
