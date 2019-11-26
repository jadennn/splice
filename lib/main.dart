import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splice/locale/cupertino_localisations_delegate.dart';
import 'package:splice/locale/project_localizations_delegate.dart';
import 'package:splice/page/splice.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  return runApp(SpliceApp());
}

class SpliceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(child: MaterialApp(
      title: '万能拼',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplicePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ProjectLocalizationsDelegate.delegate,
        CupertinoLocalisationsDelegate.delegate,
      ],
    ));
  }
}