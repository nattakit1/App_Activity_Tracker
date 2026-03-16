import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/activity.dart';


class ActivityProvider with ChangeNotifier {

  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  String searchText = "";
  String selectedType = "All";

  ActivityProvider() {
    loadActivities();   // โหลดข้อมูลทันทีตอนเปิดแอป
  }

  Future loadActivities() async {

    _activities = await DatabaseHelper.instance.getActivities();

    notifyListeners();
  }

  Future addActivity(Activity activity) async {

    await DatabaseHelper.instance.insertActivity(activity);

    await loadActivities();
  }

  Future updateActivity(Activity activity) async {

    await DatabaseHelper.instance.updateActivity(activity);

    await loadActivities();
  }

  Future deleteActivity(int id) async {

    await DatabaseHelper.instance.deleteActivity(id);

    await loadActivities();
  }

  List<Activity> get filteredActivities {

    return _activities.where((a) {

      final matchSearch =
          a.name.toLowerCase().contains(searchText.toLowerCase());

      final matchType =
          selectedType == "All" || a.type == selectedType;

      return matchSearch && matchType;

    }).toList();
  }

  int get totalActivities => _activities.length;

  int get totalHours =>
      _activities.fold(0, (sum, item) => sum + item.hours);

  int get joinedActivities =>
      _activities.where((a) => a.status == "Joined").length;
}