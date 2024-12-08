import 'package:intl/intl.dart';

  // Create a list of day names, starting with Monday
  List<String> dayNames = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
String getCurrentDay() {
  // Get the current date and time
  DateTime now = DateTime.now();


  // The DateTime.weekday returns an integer (1 for Monday, 7 for Sunday)
  return dayNames[now.weekday - 1];
}

List<String> getAllDayHours() {
  List<String> hours = [];
  for (int i = 1; i <= 24; i++) {
    String hourType = i < 12 ? "AM" : "PM";
    int hour = i % 12 == 0
        ? 12
        : i % 12; // Convert 0 to 12 for midnight, and use 12-hour format
    if (i == 24) {
      hourType = "AM"; // 24:00 is essentially 12 AM
    }
    String formattedHour = "$hour:00 $hourType";
    hours.add(formattedHour);
  }
  return hours;
}

// Function to return formatted date as "Month Name; yyyy"
String formatDate() {
  DateTime date = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM; yyyy');
  return formatter.format(date);
}

Map<String, int> getDayNumber() {
  List<String> weekDays = [];
  Map<String, int> dayToNumber = {};
  final now = DateTime.now();
  // Find the start of the current week (Monday)
  final currentWeekday = now.weekday;
  final daysToMonday = currentWeekday - DateTime.monday;
  final startOfWeek = now.subtract(Duration(days: daysToMonday));

  weekDays = [];
  dayToNumber = {};
  for (int i = 0; i < 7; i++) {
    final day = startOfWeek.add(Duration(days: i));
    final dayName = DateFormat('EEE').format(day); // 3-letter day abbreviation
    final dayNumber = day.day; // Day number in the month

    weekDays.add(dayName);
    dayToNumber[dayName] = dayNumber;
  }
  return dayToNumber;
}
