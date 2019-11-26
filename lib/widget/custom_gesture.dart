import 'dart:async';

import 'package:flutter/material.dart';

import 'custom_global_key.dart';

///自定义手势
class CustomGesture extends StatelessWidget {
  static const int LONG_PRESS_TIME = 300; //300 毫秒
  final Widget child;
  final Function onTap; //点击事件
  final Function onLongPressedDragBegin; //长按拖拽事件更新
  final Function onLongPressedDragUpdate; //长按拖拽事件更新
  final Function onLongPressedDragEnd; //长按拖拽事件结束
  final Function onDragRelease; //拖拽事件结束,释放
  final bool vertical;

  const CustomGesture({
    Key key,
    this.onTap,
    this.onLongPressedDragBegin,
    this.onLongPressedDragUpdate,
    this.onLongPressedDragEnd,
    this.onDragRelease,
    this.vertical = false,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    int endTime = DateTime.now().millisecondsSinceEpoch;
    bool isLongPress = false;
    Rect initRect = Rect.fromLTRB(0, 0, 0, 0); //子child的初始位置
    Offset lastOffset = Offset(0, 0);
    Timer time;
    return Listener(
      child: child,
      onPointerDown: (PointerDownEvent event) {
        time = Timer(Duration(milliseconds: LONG_PRESS_TIME), () {
          ///这个if判断是为了避免与ListView滑动冲突
          if (vertical) {
            //垂直的ListView
            if ((lastOffset.dx - event.position.dx).abs() >=
                (lastOffset.dy - event.position.dy).abs()) {
              isLongPress = true;
              if (onLongPressedDragBegin != null) {
                onLongPressedDragBegin(
                    initRect, lastOffset - event.position, lastOffset);
              }
            }
          } else {
            //水平的ListView
            if ((lastOffset.dx - event.position.dx).abs() <=
                (lastOffset.dy - event.position.dy).abs()) {
              isLongPress = true;
              if (onLongPressedDragBegin != null) {
                onLongPressedDragBegin(
                    initRect, lastOffset - event.position, lastOffset);
              }
            }
          }
        });
        startTime = DateTime.now().millisecondsSinceEpoch;
        initRect = measureChild(key);
        lastOffset = event.position;
      },
      onPointerMove: (PointerMoveEvent event) {
        if (isLongPress) {
          if (onLongPressedDragUpdate != null) {
            onLongPressedDragUpdate(
                initRect, event.position - lastOffset, event.position);
          }
        }
        lastOffset = event.position;
      },
      onPointerUp: (PointerUpEvent event) {
        if (time != null && time.isActive) {
          time.cancel();
        }
        endTime = DateTime.now().millisecondsSinceEpoch;
        if (isLongPress) {
          if (onLongPressedDragEnd != null) {
            onLongPressedDragEnd(
                initRect, event.position - lastOffset, event.position);
          }
          isLongPress = false;
        } else if (endTime - startTime < LONG_PRESS_TIME &&
            endTime - startTime > 0) {
          if (onTap != null) {
            onTap();
          }
        }
        lastOffset = event.position;
        if (onDragRelease != null) {
          onDragRelease();
        }
      },
      onPointerCancel: (PointerCancelEvent event) {
        if (time != null && time.isActive) {
          time.cancel();
        }
        if (isLongPress) {
          if (onLongPressedDragEnd != null) {
            onLongPressedDragEnd(
                initRect, event.position - lastOffset, event.position);
          }
          isLongPress = false;
        }
        lastOffset = event.position;
        if (onDragRelease != null) {
          onDragRelease();
        }
      },
    );
  }

  ///是否属于长按的范围
  bool isInLongPress(int start) {
    int current = DateTime.now().millisecondsSinceEpoch;
    if (current - start >= LONG_PRESS_TIME) {
      return true;
    }
    return false;
  }

  ///计算子child的位置
  Rect measureChild(CustomGlobalKey key) {
    RenderBox renderObject = key.currentContext.findRenderObject();
    final position = renderObject.localToGlobal(Offset.zero);
    double currentW = renderObject.paintBounds.size.width;
    double currentH = renderObject.paintBounds.size.height;
    return Rect.fromLTWH(position.dx, position.dy, currentW, currentH);
  }
}
