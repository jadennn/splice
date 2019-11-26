import 'package:flutter/material.dart';
import 'package:splice/manager/element_manager.dart';

import 'element_item.dart';

class ElementGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: ElementManager.instance.elements.length,
      itemBuilder: (BuildContext context, int position) {
        return ElementWidget(
          element: ElementManager.instance.elements[position],
        );
      },
    );
  }
}
