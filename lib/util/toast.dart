import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

///弹toast工具类
class ToastUtil{
  ///展示出错后的提示，警示
  static void showError(String msg){
    showToast(
        msg,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
        textStyle: TextStyle(fontSize: 16.0, color: Colors.red),
        dismissOtherToast: true,
    );
  }

  ///展示正常操作的提示，通知
  static void showTips(String msg){
    showToast(
        msg,
        duration: Duration(seconds: 2),
      backgroundColor: Colors.grey,
      textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
      //dismissOtherToast: true,
    );
  }
}