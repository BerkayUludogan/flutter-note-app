
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._internal();
  static LocaleManager get instance => _instance;

  LocaleManager._internal();
  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> clearAll() async {
    if (_preferences != null) {
      return await _preferences!.clear();
    }
    return false;
  }
/* 
  Future<bool> delete() async {
    MyNoteModel myNoteModel;
    if (_preferences != null) {
      return await _preferences!.remove(myNoteModel!.toString());
    }
    return false;
  } */

  Future<bool> setString(PreferencesKey key, String value) async {
    if (_preferences != null) {
      return await _preferences!.setString(key.name, value);
    }
    return false;
  }
  String? getString(PreferencesKey key) {
    if (_preferences != null) {
      return _preferences!.getString(key.name);
    }
    return null;
  }
}

enum PreferencesKey { note }









/* import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager.internal();
  static LocaleManager get instance => _instance;
  LocaleManager.internal();
  SharedPreferences? _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> clearAll() async => await _preferences!.clear();
  Future<bool> setString(PreferencesKey key, String value) async {
    return await _preferences!.setString('note', value);
  }

  String? getString(PreferencesKey key) {
    return _preferences!.getString(key.name);
  }
}

enum PreferencesKey { note }
 */