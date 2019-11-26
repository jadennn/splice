import 'package:flutter/material.dart';
import 'dart:math';

///屏幕适配工具
///将屏幕适配成自定义的宽高，兼容所有的设备
class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  //设计稿的设备尺寸修改
  double width;
  double height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  static double _scaleWidth;
  static double _scaleHeight;

  ScreenUtil({
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context, double width, double height) {
    this.width = width;
    this.height = height;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _scaleWidth = _screenWidth / width;
    _scaleHeight = _screenHeight / height;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight * _pixelRatio;

  ///底部安全区距离
  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  ///实际的dp与设计稿px的比例
  get scaleWidth => _scaleWidth;

  get scaleHeight => _scaleHeight;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  optWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  optHeight(double height) => height * scaleHeight;

  /// 根据设计稿中的设备宽度居中适配
  ///  计算方法为(屏幕总宽-控件宽度)/2
  optHorizontalCenter(double width) => (screenWidthDp - optWidth(width)) * 0.5;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  optSp(double fontSize) => allowFontScaling
      ? optWidth(fontSize)
      : optHeight(fontSize) / _textScaleFactor;

  ///对于坐标点的计算
  Point optPoint(Point p) {
    return Point(optWidth(p.x), optHeight(p.y));
  }
}
