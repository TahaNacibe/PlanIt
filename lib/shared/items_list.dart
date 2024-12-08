import 'package:flutter/material.dart';
import 'package:plan_it/models/days.dart';

List<Days> weekDays = [
  Days(day: "Mon", tasks: []),
  Days(day: "Tue", tasks: []),
  Days(day: "Wed", tasks: []),
  Days(day: "Thu", tasks: []),
  Days(day: "Fri", tasks: []),
  Days(day: "Sat", tasks: []),
  Days(day: "Sun", tasks: []),
];

final List<MaterialColor> colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
];

bool isDarkMood = false;
String qut = "";
