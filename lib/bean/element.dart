import 'dart:ui';

import 'package:splice/bean/general.dart';

///普通Element
class ElementBean {
  //元素类型
  ElementType type;

  //元素位置
  String location;

  ElementBean({this.type = ElementType.BUILD_IN, this.location});
}

///拖拽中的元素
class DraggedElement {
  DraggedElement({this.element, this.rect, this.current, this.offset});

  dynamic element; //元素
  Rect rect; //坐标范围
  Offset current; //手指的位置
  Offset offset; //偏移
}

///拖拽中的元素
class PositedElement {
  PositedElement({this.element, this.rect});

  dynamic element; //元素
  Rect rect; //坐标范围

  Offset lastOffset;
  double initW;
  double initH;
}
