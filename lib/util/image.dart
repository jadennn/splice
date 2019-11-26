import 'dart:typed_data';
import 'dart:ui' as dui;

import 'package:flutter/rendering.dart';
import 'package:splice/widget/custom_global_key.dart';

///图片相关
class ImageUtil {
  ///生成缩略图
  static Future<Uint8List> generateSnapshot(CustomGlobalKey key) async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();

    var dpr = dui.window.devicePixelRatio;
    dui.Image image = await boundary.toImage(pixelRatio: dpr);
    ByteData byteData = await image.toByteData(format: dui.ImageByteFormat.png);

    Uint8List snapshot = byteData.buffer.asUint8List();
    return snapshot;
  }
}