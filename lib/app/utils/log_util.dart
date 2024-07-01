import 'package:flutter/foundation.dart';

void dLog(dynamic val) {
  if (kDebugMode) {
    print(val.toString());
  }
}
