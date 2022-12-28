import 'dart:convert';
import 'dart:js';

import 'package:flutter_todo_list/todo_list/models/todo_item_model.dart';

import '../constants.dart';
import '../enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  Future<void> setLocalePreference(LocaleType localeType) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(kLanguagePreferenceKey, localeType.index);
  }

  Future<LocaleType> getLocalePreference() async {
    final prefs = await SharedPreferences.getInstance();

    final languagePreference = prefs.getInt(kLanguagePreferenceKey);

    if (languagePreference == null) {
      await setLocalePreference(LocaleType.english);
      return LocaleType.english;
    }

    return LocaleType.values[languagePreference];
  }
}
