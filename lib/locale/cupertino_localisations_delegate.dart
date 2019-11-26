import 'package:flutter/cupertino.dart';

//ios相关
class CupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(CupertinoLocalisationsDelegate old) => false;

  static CupertinoLocalisationsDelegate delegate =
      const CupertinoLocalisationsDelegate();
}
