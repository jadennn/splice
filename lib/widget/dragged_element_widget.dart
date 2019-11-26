import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';

import 'common_element.dart';

class DraggedElementWidget extends StatelessWidget {
  final DraggedElement element;

  DraggedElementWidget({Key key, @required this.element})
      : assert(element != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonElement(element: element.element),
      width: element.rect.width,
      height: element.rect.height,
    );
  }
}
