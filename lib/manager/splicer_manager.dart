import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';

class SplicerManager {
  // 工厂模式
  factory SplicerManager() => _getInstance();

  static SplicerManager get instance => _getInstance();
  static SplicerManager _instance;

  SplicerManager._internal() {
    _init();
  }

  static SplicerManager _getInstance() {
    if (_instance == null) {
      _instance = SplicerManager._internal();
    }
    return _instance;
  }

  List<PositedElement> splicers;

  void _init() async {
    splicers = List();
  }
}
