import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/event/event.dart';
import 'package:splice/manager/event_manager.dart';
import 'package:splice/manager/splicer_manager.dart';

import 'common_element.dart';

class DrawBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawBoardState();
  }
}

class DrawBoardState extends State<DrawBoard> {
  List<PositedElement> _splicers;

  PositedElement _selectedElement;

  @override
  void initState() {
    super.initState();
    _init();
    _initEventBus();
  }

  void _init() {
    _splicers = SplicerManager.instance.splicers;
  }

  ///消息通知EventBus
  void _initEventBus() {
    EventBusManager.instance.on<OpenElementEvent>((event) {
      if (this.mounted) {
        setState(() {
          _splicers.add(event.element);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplicers();
  }

  Widget _buildSplicers() {
    return Stack(
      children: _buildSplicersList(),
    );
  }

  List<Widget> _buildSplicersList() {
    List<Widget> widgets = List();
    if (_splicers != null) {
      for (PositedElement element in _splicers) {
        widgets.add(Positioned.fromRect(
          child: GestureDetector(
            child: CommonElement(
              element: element.element,
              selected: element==_selectedElement,
              onPanUpdateScale: (details){
                _onElementPanUpdate(element, details);
              },
            ),
            onScaleStart: (details) {
              _onScaleStart(element, details);
            },
            onScaleUpdate: (details) {
              _onScaleUpdate(element, details);
            },
            onScaleEnd: (ScaleEndDetails details) {
              _onScaleEnd(element);
            },
            onTap: (){
              _onTap(element);
            },
          ),
          rect: element.rect,
        ));
      }
    }
    return widgets;
  }

  ///窗口双手指缩放
  void _onScaleUpdate(PositedElement element, ScaleUpdateDetails details) {
    if (this.mounted) {
      setState(() {
        double offsetX = details.focalPoint.dx - element.lastOffset.dx;
        double offsetY = details.focalPoint.dy - element.lastOffset.dy;
        double left = element.rect.left + offsetX;
        double top = element.rect.top + offsetY;
        double width = element.initW * details.scale;
        double height = element.initH * details.scale;
        if (details.scale != 1.0) {
          double dx = element.rect.left + width - element.rect.right;
          double dy = element.rect.top + height - element.rect.bottom;
          top -= dy / 2;
          left -= dx / 2;
        }
        element.rect = Rect.fromLTWH(left, top, width, height);
        //上次的记录查询
        element.lastOffset = details.focalPoint;
      });
    }
  }

  ///窗口双手指缩放开始
  void _onScaleStart(PositedElement element, ScaleStartDetails details) {
    element.lastOffset = details.focalPoint;
    element.initW = element.rect.width;
    element.initH = element.rect.height;
  }

  ///窗口双手指缩放结束
  void _onScaleEnd(PositedElement element) {
    if (this.mounted) {
      setState(() {});
    }
  }

  void _onTap(PositedElement element){
    setState(() {
      _selectedElement = element;
    });
  }

  ///拖拽右下角放大缩小
  void _onElementPanUpdate(PositedElement element, DragUpdateDetails details){
    double right = element.rect.right +  details.delta.dx;
    double bottom = element.rect.bottom +  details.delta.dy;
    if (right - element.rect.left < 50) {
      right = element.rect.left + 50;
    }
    if (bottom - element.rect.top < 50) {
      bottom = element.rect.top + 50;
    }
    if(this.mounted){
      setState(() {
        element.rect = Rect.fromLTRB(element.rect.left, element.rect.top, right, bottom);
      });
    }
  }
}
