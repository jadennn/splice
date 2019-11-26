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
import 'package:image_picker/image_picker.dart';

class SplicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpliceState();
  }
}

class SpliceState extends State<SplicePage> {
  bool _fullScreen;
  bool _granted;
  bool _isBgPic;
  Color _bgColor;
  Key _painterKey;
  File _bgFile;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context, 0, 0);
    return Material(
      child: _granted
          ? Stack(
              children: <Widget>[
                _buildDrawBoard(),
                Positioned(
                    child: _buildElementGroup(),
                    bottom: 0,
                    height: 150,
                    width: ScreenUtil.screenWidthDp),
                _buildMenu(),
                _buildDraggedPage(),
                _buildExitFullScreen(),
                Positioned(
                  child: _buildSave(),
                  right: 0,
                ),
              ],
            )
          : Container(
              child: Center(
                child: Text("No Permission"),
              ),
            ),
    );
  }

  Widget _buildMenu() {
    return Offstage(
      offstage: _fullScreen,
      child: Container(
        color: Color(0x22ffffff),
        child: Flex(
          direction: Axis.horizontal,
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
                onPressed: _setFullScreen,
                icon: Icon(Icons.fullscreen),
                label: Text("")),
            FlatButton.icon(
                onPressed: _saveImage, icon: Icon(Icons.save), label: Text("")),
          ],
        ),
      ),
    );
  }

  ///构建绘画的元素
  Widget _buildElementGroup() {
    return Offstage(
      offstage: _fullScreen,
      child: Container(
        child: ElementGroup(),
        color: Color(0x22ffffff),
      ),
    );
  }

  ///构建绘画板，最终会转成图片
  Widget _buildDrawBoard() {
    return RepaintBoundary(
      child: _isBgPic && _bgFile != null
          ? Stack(
              children: <Widget>[
                Positioned.fill(child: Image.file(_bgFile)),
                DrawBoard(),
              ],
            )
          : Container(
              child: DrawBoard(),
              color: _bgColor,
            ),
      key: _painterKey,
    );
  }

  ///构建拖拽的动画
  Widget _buildDraggedPage() {
    return DragWidget();
  }

  Widget _buildExitFullScreen() {
    return Offstage(
      offstage: !_fullScreen,
      child: FlatButton.icon(
          onPressed: _exitFullScreen, icon: Icon(Icons.clear), label: Text("")),
    );
  }

  Widget _buildSave() {
    return Offstage(
      offstage: !_fullScreen,
      child: FlatButton.icon(
          onPressed: _saveImage, icon: Icon(Icons.save), label: Text("")),
    );
  }

  void _init() {
    _fullScreen = false;
    _granted = false;
    _isBgPic = false;
    _bgColor = Colors.white;
    _painterKey = CustomGlobalKey("DrawBoard");
    PermissionUtil.requestPermission(context, PermissionGroup.storage)
        .then((result) async {
      if ((Platform.isIOS || result)) {
        if (mounted) {
          setState(() {
            _granted = true;
          });
        }
      }
    });
  }

  ///弹出颜色选择框
  void _showColorPicker() {
    CustomDialog.show(context,
        child: Container(
          child: ColorPicker((isCustomer, color) {
            if (isCustomer) {
              CustomDialog.dismiss(context);
              _showPicker();
            } else {
              CustomDialog.dismiss(context);
              _isBgPic = isCustomer;
              if (!isCustomer) {
                if (mounted) {
                  setState(() {
                    _bgColor = color;
                  });
                }
              }
            }
          }),
          width: 300,
          height: 200,
        ));
  }

  ///弹出背景选择框
  void _showPicker() async {
    _isBgPic = true;
    _bgFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (this.mounted) {
      setState(() {});
    }
  }

  ///保存图片
  void _saveImage() {
    ImageUtil.generateSnapshot(_painterKey).then((value) async {
      final result = await ImageGallerySaver.saveImage(value);
      ToastUtil.showTips("save success : $result");
    });
  }

  ///全屏
  void _setFullScreen() {
    if (this.mounted) {
      setState(() {
        _fullScreen = true;
      });
    }
  }

  ///退出全屏
  void _exitFullScreen() {
    if (this.mounted) {
      setState(() {
        _fullScreen = false;
      });
    }
  }
}
