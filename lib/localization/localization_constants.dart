import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'demo_localization.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).getTranslatedValue(key);
}

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  setPrefCurrentLang(languageCode);
  saveCurrentLangInDB(languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await getPrefCurrentLang();
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    case ARABIC:
      _temp = Locale(languageCode, 'EG');
      break;
    default:
      _temp = Locale(languageCode, 'US');
  }
  return _temp;
}
