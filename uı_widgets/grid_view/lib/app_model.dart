import 'package:flutter/material.dart';

class AppModel {
  Icon appIcon;
  String appName;
  DateTime releaseDate;
  String appCategory;
  String storeUrl;

  AppModel({
    required this.appIcon,
    required this.appName,
    required this.releaseDate,
    required this.appCategory,
    required this.storeUrl,
  });
}
