import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<String?> getWeeklyTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("weekly_namaz");
  }

  static setWeeklyTime(String wTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("weekly_namaz", wTime);
  }


  static Future<int> getScheduleId() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getInt("getSchedule") ?? 0;
  }

  static setSchedule(int scheduleId) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("getSchedule   $scheduleId");
    prefs.setInt("getSchedule", scheduleId);
  }

  static clearAppPreference() async {
    prefs = await getInstance();
    prefs?.clear();
  }
}
