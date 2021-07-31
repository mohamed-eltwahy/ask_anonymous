import 'package:get/get.dart';

import 'language/ar.dart';

class Translation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    // 'en':en,
    'ar':ar
  };
}