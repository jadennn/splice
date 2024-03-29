import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:splice/manager/config_manager.dart';

class ColorPicker extends StatelessWidget {
  ColorPicker(this.choose);

  final Function choose;

  @override
  Widget build(BuildContext context) {
    return Container(child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: ConfigManager.instance.colors.length + 1,
      itemBuilder: (BuildContext context, int position) {
        if (position == ConfigManager.instance.colors.length) {
          return GestureDetector(
            child: Container(
              child: Icon(Icons.add),
              width: ConfigManager.instance.elementWidth,
              height: ConfigManager.instance.elementHeight,
            ),
            onTap: () {
              choose(true, null);
            },
          );
        }
        return GestureDetector(
          child: Container(
              color: ConfigManager.instance.colors[position],
              width: ConfigManager.instance.elementWidth,
              height: ConfigManager.instance.elementHeight),
          onTap: () {
            choose(false, ConfigManager.instance.colors[position]);
          },
        );
      },
    ),color: Color(0x22222222), padding: EdgeInsets.all(5.0),);
  }
}

///加载弹框
class CustomDialog {
  static bool _isShowing = false;

  ///展示
  static void show(BuildContext context,
      {Widget child = const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.red),
      )}) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _Progress(
            child: child,
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

///Widget
class _Progress extends StatelessWidget {
  final Widget child;

  _Progress({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: child,
        ));
  }
}

class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
