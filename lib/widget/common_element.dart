import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';

class CommonElement extends StatelessWidget {
  final ElementBean element;
  final bool selected;
  final Function onPanUpdateScale;
  final Function onPanEndScale;

  CommonElement({Key key, @required this.element, this.selected = false, this.onPanEndScale, this.onPanUpdateScale})
      : assert(element != null && element.type != ElementType.ADD),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Stack(
        children: <Widget>[
          _buildElementByType(element),
          Positioned(
            child: GestureDetector(
              child: Image.asset("assets/images/right_bottom.png", width: 15, height: 15,),
              onPanUpdate: (DragUpdateDetails details) {
                if (onPanUpdateScale != null) {
                  onPanUpdateScale(details);
                }
              },
              onPanEnd: (s) {
                if (onPanEndScale != null) {
                  onPanEndScale();
                }
              },
            ),
            right: 0,
            bottom: 0,
          ),
        ],
        fit: StackFit.expand,
      );
    } else {
      return _buildElementByType(element);
    }
  }

  //构建元素
  Widget _buildElementByType(ElementBean element) {
    if (element.type == ElementType.BUILD_IN) {
      return Image.asset(
        element.location,
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        new File(element.location),
        fit: BoxFit.fill,
      );
    }
  }
}
