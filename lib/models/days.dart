import 'package:plan_it/models/item.dart';

class Days {
  String day;
  List<Item> tasks;

  Days({
    required this.day,
    required this.tasks,
  });

  // Convert Days to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'tasks': tasks.map((item) => item.toJson()).toList(),
    };
  }

  // Convert JSON to Days
  factory Days.fromJson(Map<String, dynamic> json) {
    return Days(
      day: json['day'],
      tasks: (json['tasks'] as List)
          .map((task) => Item.fromJson(task))
          .toList(),
    );
  }
}
