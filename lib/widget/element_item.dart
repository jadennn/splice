import 'package:flutter/material.dart';
import 'package:splice/event/event.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';
import 'package:splice/manager/event_manager.dart';

import 'common_element.dart';
import 'custom_gesture.dart';
import 'custom_global_key.dart';

///子元素布局
class ElementWidget extends StatefulWidget {
  final ElementBean element;

  ElementWidget({Key key, @required this.element})
      : assert(element != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ElementWidgetState();
  }
}

class ElementWidgetState extends State<ElementWidget> {
  Rect _rect = Rect.fromLTRB(0, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return _buildElementByType();
  }

  //构建元素
  Widget _buildElementByType() {
    if (widget.element.type == ElementType.ADD) {
      return Icon(Icons.add);
    } else {
      return CustomGesture(
        child: CommonElement(
          element: widget.element,
        ),
        key: CustomGlobalKey(
            "${widget.element.type}_${widget.element.location}"),
        vertical: false,
        onLongPressedDragBegin: _dragBegin,
        onLongPressedDragEnd: _dragEnd,
        onLongPressedDragUpdate: _dragUpdate,
        onDragRelease: _dragRelease,
      );
    }
  }

  void _dragBegin(Rect rect, Offset offset, Offset currentPoint) {
    _rect = rect.shift(offset);
    EventBusManager.instance.emit(DragEvent(
        DragType.START,
        DraggedElement(
            element: widget.element,
            offset: offset,
            current: currentPoint,
            rect: _rect)));
  }

  void _dragUpdate(Rect rect, Offset offset, Offset currentPoint) {
    _rect = _rect.shift(offset);
    EventBusManager.instance.emit(DragEvent(
        DragType.UPDATE,
        DraggedElement(
            element: widget.element,
            offset: offset,
            current: currentPoint,
            rect: _rect)));
  }

  void _dragEnd(Rect rect, Offset offset, Offset currentPoint) {
    _rect = _rect.shift(offset);
    EventBusManager.instance.emit(DragEvent(
        DragType.END,
        DraggedElement(
            element: widget.element,
            offset: offset,
            current: currentPoint,
            rect: _rect)));
  }

  void _dragRelease() {
    EventBusManager.instance
        .emit(DragEvent(DragType.RELEASE, DraggedElement()));
  }
}
