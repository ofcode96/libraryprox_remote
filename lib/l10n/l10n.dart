// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/constents/languages.dart';

class L10n {
  static final all = languages.map((lng) => Locale(lng)).toList();
}
