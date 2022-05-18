import 'package:jobtrackeremployee/models/job_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  saveList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  readList(String? key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key!);
  }

  setString(String? key, String? value)async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key!, value!);
  }

  getString(String? key)async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }
}
