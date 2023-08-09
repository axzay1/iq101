import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/pref_status.dart';

class SharedPrefs {
  Future<bool> clearAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.clear();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> checkStatus(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(prefName);
  }

  bool checkForPrefValidity(SharedPreferences prefs, String prefName) {
    return prefs.containsKey(prefName);
  }

  Future<bool> removePrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return false;
    }
    await prefs.remove(prefName);
    return true;
  }

  Future<void> addStringPrefs(String prefName, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefName, value);
  }

  Future<void> addDoublePrefs(String prefName, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(prefName, value);
  }

  Future<void> addIntPrefs(String prefName, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefName, value);
  }

  Future<void> addBoolPrefs(String prefName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefName, value);
  }

  Future<void> addMapPrefs(String prefName, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefName, json.encode(value));
  }

  Future<PrefsStatus> getBoolPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefsStatus(status: false, value: null);
    }
    dynamic value = prefs.getBool(prefName);
    return PrefsStatus(status: true, value: value);
  }

  Future<PrefsStatus> getIntPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefsStatus(status: false, value: null);
    }
    dynamic value = prefs.getInt(prefName);
    return PrefsStatus(status: true, value: value);
  }

  Future<PrefsStatus> getStringPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefsStatus(status: false, value: null);
    }
    dynamic value = prefs.getString(prefName);
    return PrefsStatus(status: true, value: value);
  }

  Future<PrefsStatus> getDoublePrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefsStatus(status: false, value: null);
    }
    dynamic value = prefs.getDouble(prefName);
    return PrefsStatus(status: true, value: value);
  }

  Future<PrefsStatus> getMapPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefsStatus(status: false, value: null);
    }
    String? value = prefs.getString(prefName);
    return PrefsStatus(status: true, value: json.decode(value!));
  }
}
