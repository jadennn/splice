import 'package:flutter/material.dart';

class ConfigManager {
  // 工厂模式
  factory ConfigManager() => _getInstance();

  static ConfigManager get instance => _getInstance();
  static ConfigManager _instance;

  ConfigManager._internal() {
    _init();
  }

  static ConfigManager _getInstance() {
    if (_instance == null) {
      _instance = ConfigManager._internal();
    }
    return _instance;
  }

  void _init() async {
    colors = List();
    colors.add(Colors.red);
    colors.add(Colors.white);
    colors.add(Colors.green);
    colors.add(Colors.black);
    colors.add(Colors.blue);
    colors.add(Colors.amber);
  }

  //元素宽
  double elementWidth = 10;

  //元素高
  double elementHeight = 10;

  List<Color> colors;
}
