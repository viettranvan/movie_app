import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer? _timer;
  Debouncer({
    this.duration = const Duration(milliseconds: 100),
  });
  call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  bool callWithValue(VoidCallback callback, bool notification) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
    return notification;
  }

  dispose() {
    _timer?.cancel();
  }
}

// class DebouncerScroll {
//   final Duration duration;
//   Timer? _timer;
//   DebouncerScroll({
//     this.duration = const Duration(milliseconds: 500),
//   });

//   dispose() {
//     _timer?.cancel();
//   }
// }
