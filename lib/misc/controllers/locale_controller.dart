import 'dart:ui';

import 'package:get/get.dart';

import '../enums.dart';

enum LanguageCode { en }

class LocaleController extends GetxController {
  Rx<LocaleType> localeType = LocaleType.english.obs;

  String get languageCode {
    return LanguageCode.values[localeType.value.index]
        .toString()
        .split('.')
        .last;
  }

  bool get isCurrentLocaleEnglish => localeType.value == LocaleType.english;

  void switchLocale(LocaleType localeType) {
    if (this.localeType.value != localeType) {
      this.localeType.value = localeType;
      Get.updateLocale(Locale(languageCode));
    }
  }
}