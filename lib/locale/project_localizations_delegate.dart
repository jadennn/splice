import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'project_localizations.dart';

///国际化
class ProjectLocalizationsDelegate
    extends LocalizationsDelegate<ProjectLocalizations> {
  const ProjectLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  Future<ProjectLocalizations> load(Locale locale) {
    return SynchronousFuture(ProjectLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<ProjectLocalizations> old) {
    return false;
  }

  static ProjectLocalizationsDelegate delegate =
      const ProjectLocalizationsDelegate();
}
