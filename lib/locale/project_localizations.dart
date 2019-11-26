import 'dart:ui';

import 'package:flutter/widgets.dart';

///国际化相关
class ProjectLocalizations {
  final Locale locale;

  ///某些情况下获取不到BuildContext，因此没有办法获取多语言，
  ///为了解决这些场景下的多语言，采用上一次的locale进行保存
  static Locale lastLocale;

  ProjectLocalizations(this.locale){
    lastLocale = locale;
  }


  static Map<String, Map<String, String>> _localizedValues = {
    "en": {
      "Permission": "Permission",
      "PermissionContent": "ALlow Permissions To Contiune This APP ",
      "Cancel": "Cancel",
      "OK": "Confirm",
    },
    "zh": {
      "Permission": "权限申请",
      "PermissionContent": "为了应用的正常运行， 请在设置中打开相应的权限 ",
      "OK": "确定",
      "Cancel": "取消",
    }
  };

  get permission => _localizedValues[locale.languageCode]["Permission"];
  get permissionContent => _localizedValues[locale.languageCode]["PermissionContent"];
  get ok => _localizedValues[locale.languageCode]["OK"];
  get cancel => _localizedValues[locale.languageCode]["Cancel"];

  static ProjectLocalizations of(BuildContext context) {
    return Localizations.of(context, ProjectLocalizations);
  }

  static ProjectLocalizations noContext(){
    return ProjectLocalizations(lastLocale);
  }
}
