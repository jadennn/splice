import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';

///拖拽事件
class DragEvent {
  DraggedElement draggedElement; //被拖拽的元素属性
  DragType type; //拖拽类型
  DragEvent(this.type, this.draggedElement);
}

///添加element事件
class OpenElementEvent {
  PositedElement element;

  OpenElementEvent(this.element);
}
