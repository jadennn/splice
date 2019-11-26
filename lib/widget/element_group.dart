import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splice/bean/element.dart';
import 'package:splice/bean/general.dart';
import 'package:splice/manager/element_manager.dart';

import 'element_item.dart';
import 'package:image_picker/image_picker.dart';

class ElementGroup extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ElementGroupState();
  }
}


class ElementGroupState extends State<ElementGroup>{

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
          showPicker: _showPicker,
        );
      },
    );
  }

  void _showPicker() async{
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image != null){
      ElementManager.instance.elements.add(ElementBean(location: image.path, type: ElementType.CUSTOM));
    }
    if(this.mounted){
      setState(() {
      });
    }
  }

}
