import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:splice/locale/project_localizations.dart';

///权限请求
class PermissionUtil {
  ///请求单个权限
  static Future<bool> requestPermission(
      BuildContext context, PermissionGroup permission) async {
    List<PermissionGroup> list = List();
    list.add(permission);
    PermissionStatus status =
        await PermissionHandler().checkPermissionStatus(permission);
    if (status != PermissionStatus.granted) {
      bool show = await PermissionHandler()
          .shouldShowRequestPermissionRationale(permission);
      if (show) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                    title:
                        new Text(ProjectLocalizations.of(context).permission),
                    content: new Text(
                        "${ProjectLocalizations.of(context).permissionContent}${permission.toString()}"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text(
                          ProjectLocalizations.of(context).cancel,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        child: new Text(
                          ProjectLocalizations.of(context).ok,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          PermissionHandler().openAppSettings();
                        },
                      )
                    ]));
        return false;
      } else {
        Map<PermissionGroup, PermissionStatus> map =
            await PermissionHandler().requestPermissions(list);
        if (map[permission] != PermissionStatus.granted) {
          return false;
        }
      }
    }
    return true;
  }
}
