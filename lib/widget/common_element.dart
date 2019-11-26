import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';

class CommonElement extends StatelessWidget {
  final ElementBean element;

  CommonElement({Key key, @required this.element})
      : assert(element != null && element.type != ElementType.ADD),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildElementByType(element);
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
