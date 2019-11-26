import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';
import 'package:splice/event/event.dart';
import 'package:splice/manager/event_manager.dart';

import 'dragged_element_widget.dart';

///可拖拽的元素页面
class DragWidget extends StatefulWidget {
  DragWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DragWidgetState();
  }
}

class DragWidgetState extends State<DragWidget> {
  ///所用的一些参数
  DraggedElement _draggedElement;
  bool _draggedOffstage;

  @override
  void initState() {
    super.initState();
    _initParam();
    _initEventBus();
  }

  ///初始化参数
  void _initParam() {
    _draggedOffstage = true;
  }

  ///消息通知EventBus
  void _initEventBus() {
    EventBusManager.instance.on<DragEvent>((event) {
      if (this.mounted) {
        setState(() {
          _draggedElement = event.draggedElement;
          if (event.type == DragType.START) {
            _draggedOffstage = false;
          } else if (event.type == DragType.END) {
            EventBusManager.instance.emit(OpenElementEvent(PositedElement(
                element: _draggedElement.element, rect: _draggedElement.rect)));
          } else if (event.type == DragType.RELEASE) {
            _draggedOffstage = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildDraggedElement();
  }

  ///增加拖拽动画
  Widget _buildDraggedElement() {
    if (!_draggedOffstage && _draggedElement != null) {
      return Stack(
        children: <Widget>[
          Positioned(
            child: DraggedElementWidget(
              element: _draggedElement,
            ),
            left: _draggedElement.rect.left,
            top: _draggedElement.rect.top,
          )
        ],
        fit: StackFit.expand,
      );
    } else {
      return Container();
    }
  }
}
