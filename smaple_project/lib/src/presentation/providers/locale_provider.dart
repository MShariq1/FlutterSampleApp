import 'package:flutter/cupertino.dart';
import 'package:smaple_project/src/core/enum/body_type.dart';

class LocaleProvider with ChangeNotifier {
  Locale locale  = const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');
  void togggle(){
    if(locale.languageCode=='en'){
      locale = const Locale.fromSubtags(languageCode: 'ar', countryCode: 'AR');
      notifyListeners();
      return;
    }
    if(locale.languageCode=='ar'){
      locale = const Locale.fromSubtags(languageCode: 'en', countryCode: 'US');
      notifyListeners();
      return;
    }

  }

}