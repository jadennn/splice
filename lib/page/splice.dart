
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splice/util/image.dart';
import 'package:splice/util/permission.dart';
import 'package:splice/util/screen.dart';
import 'package:splice/util/toast.dart';
import 'package:splice/widget/custom_global_key.dart';
import 'package:splice/widget/dialog.dart';
import 'package:splice/widget/drag_widget.dart';
import 'package:splice/widget/element_group.dart';
import 'package:splice/widget/draw_board.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SplicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpliceState();
  }
}

class SpliceState extends State<SplicePage> {
  bool _granted;
  bool _isBgPic;
  Color _bgColor;
  Key _painterKey;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context, 0, 0);
    return Material(
      child: _granted ? Stack(
        children: <Widget>[
          _buildDrawBoard(),
          Positioned(
              child: _buildElementGroup(),
              bottom: 0,
              height: 150,
              width: ScreenUtil.screenWidthDp),
          _buildMenu(),
          _buildDraggedPage(),
        ],
      ):Container(child: Center(child: Text("No Permission"),),),
    );
  }

  Widget _buildMenu() {
    return Container(
      color: Color(0x22ffffff),
      child: Row(
        children: <Widget>[
          FlatButton.icon(
              onPressed: _showColorPicker,
              icon: Icon(Icons.image),
              label: Text("")),
          FlatButton.icon(
              onPressed: _showColorPicker,
              icon: Icon(Icons.image),
              label: Text("")),
          FlatButton.icon(
              onPressed: _showColorPicker,
              icon: Icon(Icons.folder_open),
              label: Text("")),
          FlatButton.icon(
              onPressed: _saveImage,
              icon: Icon(Icons.save),
              label: Text("")),
        ],
      ),
    );
  }


  ///构建绘画的元素
  Widget _buildElementGroup() {
    return Container(child:ElementGroup() , color: Color(0x22ffffff),);
  }


  ///构建绘画板，最终会转成图片
  Widget _buildDrawBoard() {
    return RepaintBoundary(child: Container(child: DrawBoard(), color: _bgColor,),key: _painterKey,);
  }

  ///构建拖拽的动画
  Widget _buildDraggedPage() {
    return DragWidget();
  }

  void _init() {
    _granted = false;
    _isBgPic = false;
    _bgColor = Colors.white;
    _painterKey = CustomGlobalKey("DrawBoard");
    PermissionUtil.requestPermission(context, PermissionGroup.storage)
        .then((result) async {
      if ((Platform.isIOS || result)) {
        if(mounted) {
          setState(() {
            _granted = true;
          });
        }
      }
    });
  }

  void _showColorPicker() {
    CustomDialog.show(context,
        child: Container(
          child: ColorPicker((isCustomer, color) {
            CustomDialog.dismiss(context);
            _isBgPic = isCustomer;
            if (!isCustomer) {
              if (mounted) {
                setState(() {
                  _bgColor = color;
                });
              }
            }
          }),
          width: 300,
          height: 200,
        ));
  }

  void _saveImage() {
    ImageUtil.generateSnapshot(_painterKey).then((value) async{
      final result = await ImageGallerySaver.saveImage(value);
      ToastUtil.showTips("save success : $result");
    });
  }

}
