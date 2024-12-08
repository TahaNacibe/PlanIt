import 'package:flutter/material.dart';

class Item {
  String name;
  String description;
  DateTime start;
  DateTime end;
  MaterialColor color;

  Item({
    required this.name,
    required this.start,
    this.description = "",
    required this.end,
    required this.color,
  });

  // Convert Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'color': color.value.toString(), // Assuming you use color value as an int
    };
  }

  // Convert JSON to Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'] ?? "",
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      color: MaterialColor(
        int.parse(json['color']),
        <int, Color>{},
      ), // You may need to map color values properly
    );
  }

    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.name == name &&
        other.description == description &&
        other.start == start &&
        other.end == end &&
        other.color == color;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        start.hashCode ^
        end.hashCode ^
        color.hashCode;
  }
}
