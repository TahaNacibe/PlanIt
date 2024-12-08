import 'package:plan_it/keys/storage_key.dart';
import 'package:plan_it/keys/theme_key.dart';
import 'package:plan_it/models/days.dart';
import 'package:plan_it/shared/items_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<void> saveDaysList(List<Days> daysList) async {
  final prefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> jsonList =
      daysList.map((day) => day.toJson()).toList();
  String jsonString = jsonEncode(jsonList);
  await prefs.setString(storage, jsonString);
}

Future<List<Days>> loadDaysList() async {
  final prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(storage);
  if (jsonString != null) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Days.fromJson(json)).toList();
  }
  return [];
}

Future<void> saveTheme() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(themeKey, isDarkMood);
}

Future<bool> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  bool result = prefs.getBool(themeKey) ?? false;
  return result;
}
